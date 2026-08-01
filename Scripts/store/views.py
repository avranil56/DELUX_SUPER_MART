from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Customer, Product, Category, Bill, BillItem, HeroImage, CustomerLogin
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings
import os
from django.db.models import Sum, Count
from django.utils import timezone
from datetime import timedelta


# ================= AUTH =================

def customer_register(request):
    if request.method == "POST":
        username = request.POST.get("username").strip()
        password = request.POST.get("password")
        name = request.POST.get("name").strip()
        age = int(request.POST.get("age"))
        sex = request.POST.get("sex").strip().upper()

        if User.objects.filter(username=username).exists():
            return render(request, "store/register.html", {
                "error": "Username already exists"
            })

        user = User.objects.create_user(username=username, password=password)

        Customer.objects.create(
            user=user,
            customer_name=name,
            customer_age=age,
            customer_sex=sex
        )

        return redirect("login")

    return render(request, "store/register.html")


def user_login(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")
        login_type = request.POST.get("login_type")  # 'admin' or 'customer'

        # Authenticate the user first
        user = authenticate(request, username=username, password=password)

        if user is not None:
            # Check login type and validate accordingly
            if login_type == "admin":
                # Admin login - must be superuser AND provide correct PIN
                admin_pin = request.POST.get("admin_pin")

                # You can change this PIN value or store it in settings
                # For now, using a default PIN: 123456
                # Change this to your desired admin PIN
                CORRECT_ADMIN_PIN = "123456"

                if user.is_superuser and admin_pin == CORRECT_ADMIN_PIN:
                    login(request, user)
                    return redirect("admin_dashboard")
                elif not user.is_superuser:
                    # Regular user trying to login as admin
                    return render(request, "store/login.html", {
                        "admin_error": "You are not authorized as Shop Owner. Please login as Customer."
                    })
                else:
                    # Wrong PIN
                    return render(request, "store/login.html", {
                        "admin_error": "Invalid Protected PIN. Please try again."
                    })

            elif login_type == "customer":
                # Customer login - regular users only (non-superuser)
                if not user.is_superuser:
                    login(request, user)

                    # Track customer login
                    try:
                        customer = Customer.objects.get(user=user)
                        CustomerLogin.objects.create(customer=customer)
                    except Exception as e:
                        print(f"Failed to track login: {e}")

                    return redirect("customer_dashboard")
                else:
                    # Admin trying to login as customer
                    return render(request, "store/login.html", {
                        "customer_error": "Shop Owner cannot login as Customer. Please use Shop Owner login."
                    })
            else:
                # Fallback for any other login_type
                return render(request, "store/login.html", {
                    "error": "Invalid login type"
                })
        else:
            # Authentication failed
            if login_type == "admin":
                return render(request, "store/login.html", {
                    "admin_error": "Invalid username or password"
                })
            else:
                return render(request, "store/login.html", {
                    "customer_error": "Invalid username or password"
                })

    return render(request, "store/login.html")


def user_logout(request):
    logout(request)
    return redirect("login")


# ================= DASHBOARDS =================

@login_required
def admin_dashboard(request):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    products = Product.objects.all()
    return render(request, "store/admin_dashboard.html", {
        "products": products
    })


@login_required
def customer_dashboard(request):
    # MODIFIED: Get the customer's full name from the database
    try:
        customer = Customer.objects.get(user=request.user)
        customer_name = customer.customer_name
    except Customer.DoesNotExist:
        customer_name = request.user.username  # Fallback to username if no customer profile

    return render(request, "store/customer_dashboard.html", {
        'customer_name': customer_name
    })


# ================= CATEGORY =================

@login_required
def add_category(request):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    if request.method == "POST":
        name = request.POST.get("category_name")

        if Category.objects.filter(category_name=name).exists():
            return render(request, "store/add_category.html", {
                "error": "Category already exists"
            })

        Category.objects.create(category_name=name)
        return redirect("manage_categories")

    return render(request, "store/add_category.html")


@login_required
def manage_categories(request):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    categories = Category.objects.all()
    return render(request, "store/manage_categories.html", {
        "categories": categories
    })


@login_required
def delete_category(request, category_id):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    Category.objects.filter(category_id=category_id).delete()
    return redirect("manage_categories")


# ================= PRODUCT =================

@login_required
def add_product(request):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    categories = Category.objects.all()

    if request.method == "POST":
        product = Product.objects.create(
            product_name=request.POST.get("product_name"),
            price=request.POST.get("price"),
            stock_quantity=request.POST.get("stock_quantity"),
            allowed_gender=request.POST.get("allowed_gender"),
            category_id=request.POST.get("category_id"),
            is_adult_only=request.POST.get("is_adult_only") == "on"
        )

        # Handle sprite upload
        if 'product_sprite' in request.FILES:
            product.product_sprite = request.FILES['product_sprite']
            product.save()

        return redirect("admin_dashboard")

    return render(request, "store/add_product.html", {
        "categories": categories
    })


@login_required
def manage_products(request):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    categories = Category.objects.prefetch_related("products").all()
    return render(request, "store/manage_products.html", {
        "categories": categories
    })


@login_required
def delete_product(request, product_id):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    Product.objects.filter(product_id=product_id).delete()
    return redirect("manage_products")


@login_required
def update_stock(request, product_id, action):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    product = Product.objects.get(product_id=product_id)

    if action == "increase":
        product.stock_quantity += 1
    elif action == "decrease" and product.stock_quantity > 0:
        product.stock_quantity -= 1

    product.save()
    return redirect("manage_products")


@login_required
def update_price(request, product_id, action):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    product = Product.objects.get(product_id=product_id)

    if action == "increase":
        product.price += 10
    elif action == "decrease" and product.price > 10:
        product.price -= 10

    product.save()
    return redirect("manage_products")


# ================= HERO IMAGE MANAGEMENT =================

@login_required
def manage_hero_images(request):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    hero_images = HeroImage.objects.all()
    max_images = 4

    if request.method == "POST":
        # Handle image upload
        if 'hero_image' in request.FILES and hero_images.count() < max_images:
            image_file = request.FILES['hero_image']
            title = request.POST.get('title', '')
            subtitle = request.POST.get('subtitle', '')
            order = hero_images.count() + 1

            HeroImage.objects.create(
                image=image_file,
                title=title,
                subtitle=subtitle,
                order=order
            )
            messages.success(request, "Hero image added successfully!")

        # Handle image deletion
        elif 'delete_image' in request.POST:
            image_id = request.POST.get('delete_image')
            HeroImage.objects.filter(image_id=image_id).delete()
            messages.success(request, "Hero image deleted successfully!")

        return redirect('manage_hero_images')

    return render(request, "store/manage_hero_images.html", {
        "hero_images": hero_images,
        "max_images": max_images,
        "remaining_slots": max_images - hero_images.count()
    })


@login_required
def delete_hero_image(request, image_id):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    HeroImage.objects.filter(image_id=image_id).delete()
    messages.success(request, "Hero image deleted successfully!")
    return redirect('manage_hero_images')


# ================= ADMIN STATISTICS =================

@login_required
def admin_statistics(request):
    if not request.user.is_superuser:
        return redirect("customer_dashboard")

    # Get date range for last 7 days
    end_date = timezone.now()
    start_date = end_date - timedelta(days=7)

    # 1. Best selling products (by quantity)
    best_products = BillItem.objects.filter(
        bill__bill_date__range=[start_date, end_date]
    ).values(
        'product__product_id',
        'product__product_name',
        'product__category__category_name'
    ).annotate(
        total_quantity=Sum('quantity'),
        total_revenue=Sum('price_at_time') * Sum('quantity')
    ).order_by('-total_quantity')[:10]

    # 2. Trending categories (by quantity sold)
    trending_categories = BillItem.objects.filter(
        bill__bill_date__range=[start_date, end_date]
    ).values(
        'product__category__category_id',
        'product__category__category_name'
    ).annotate(
        total_quantity=Sum('quantity'),
        total_revenue=Sum('price_at_time') * Sum('quantity')
    ).order_by('-total_quantity')

    # 3. Most active customers (by login count + order count combined)
    # Get customers with most logins in last 7 days
    active_customers_login = CustomerLogin.objects.filter(
        login_time__range=[start_date, end_date]
    ).values(
        'customer__customer_id',
        'customer__customer_name',
        'customer__user__username'
    ).annotate(
        login_count=Count('login_id')
    ).order_by('-login_count')[:20]

    # Get customers with most orders in last 7 days
    active_customers_order = Bill.objects.filter(
        bill_date__range=[start_date, end_date]
    ).values(
        'customer__customer_id',
        'customer__customer_name',
        'customer__user__username'
    ).annotate(
        order_count=Count('bill_id'),
        total_spent=Sum('total_amount')
    ).order_by('-order_count')[:20]

    # Combine login and order data for display
    active_customers = {}

    # Add login data
    for customer in active_customers_login:
        cust_id = customer['customer__customer_id']
        active_customers[cust_id] = {
            'customer_id': cust_id,
            'customer_name': customer['customer__customer_name'],
            'username': customer['customer__user__username'],
            'login_count': customer['login_count'],
            'order_count': 0,
            'total_spent': 0
        }

    # Add order data
    for customer in active_customers_order:
        cust_id = customer['customer__customer_id']
        if cust_id in active_customers:
            active_customers[cust_id]['order_count'] = customer['order_count']
            active_customers[cust_id]['total_spent'] = float(customer['total_spent'])
        else:
            active_customers[cust_id] = {
                'customer_id': cust_id,
                'customer_name': customer['customer__customer_name'],
                'username': customer['customer__user__username'],
                'login_count': 0,
                'order_count': customer['order_count'],
                'total_spent': float(customer['total_spent'])
            }

    # Convert to list and sort by combined activity (login_count + order_count)
    active_customers_list = list(active_customers.values())
    active_customers_list.sort(key=lambda x: (x['login_count'] + x['order_count']), reverse=True)
    active_customers_list = active_customers_list[:10]

    # Calculate overall summary
    total_orders = Bill.objects.filter(bill_date__range=[start_date, end_date]).count()
    total_revenue = Bill.objects.filter(bill_date__range=[start_date, end_date]).aggregate(total=Sum('total_amount'))[
                        'total'] or 0
    total_items_sold = \
    BillItem.objects.filter(bill__bill_date__range=[start_date, end_date]).aggregate(total=Sum('quantity'))[
        'total'] or 0
    total_logins = CustomerLogin.objects.filter(login_time__range=[start_date, end_date]).count()
    total_customers_ordered = Bill.objects.filter(bill_date__range=[start_date, end_date]).values(
        'customer').distinct().count()

    context = {
        'start_date': start_date.strftime('%Y-%m-%d'),
        'end_date': end_date.strftime('%Y-%m-%d'),
        'best_products': best_products,
        'trending_categories': trending_categories,
        'active_customers': active_customers_list,
        'total_orders': total_orders,
        'total_revenue': total_revenue,
        'total_items_sold': total_items_sold,
        'total_logins': total_logins,
        'total_customers_ordered': total_customers_ordered,
    }

    return render(request, "store/admin_statistics.html", context)


# ================= STORE =================

@login_required
def store_page(request):
    customer = Customer.objects.get(user=request.user)

    cart = request.session.get("cart", {})
    if not isinstance(cart, dict):
        cart = {}
        request.session["cart"] = cart

    if request.method == "POST":
        product_id = request.POST.get("product_id")
        if product_id:
            cart[product_id] = cart.get(product_id, 0) + 1
            request.session["cart"] = cart
            request.session.modified = True
        return redirect("store_page")

    categories = Category.objects.prefetch_related("products").all()
    filtered_categories = []

    for category in categories:
        filtered_products = []
        for product in category.products.all():

            if product.is_adult_only and customer.customer_age < 18:
                continue

            if product.allowed_gender:
                if product.allowed_gender.upper() not in ["ALL", customer.customer_sex.upper()]:
                    continue

            filtered_products.append(product)

        category.filtered_products = filtered_products
        filtered_categories.append(category)

    # Get hero images for slideshow
    hero_images = HeroImage.objects.all()

    return render(request, "store/store_page.html", {
        "categories": filtered_categories,
        "hero_images": hero_images
    })


# ================= CART =================

@login_required
def cart_view(request):
    cart = request.session.get("cart", {})

    cart_items = []
    total = 0

    for product_id, quantity in cart.items():
        try:
            product = Product.objects.get(product_id=product_id)
            subtotal = product.price * quantity
            total += subtotal

            cart_items.append({
                "product": product,
                "quantity": quantity,
                "subtotal": subtotal
            })
        except Product.DoesNotExist:
            continue

    return render(request, "store/cart.html", {
        "products": cart_items,
        "total": total
    })


@login_required
def update_cart(request, product_id, action):
    cart = request.session.get("cart", {})
    product_id = str(product_id)

    if product_id in cart:
        if action == "increase":
            cart[product_id] += 1
        elif action == "decrease":
            cart[product_id] -= 1
            if cart[product_id] <= 0:
                del cart[product_id]
        elif action == "remove":
            del cart[product_id]

    request.session["cart"] = cart
    request.session.modified = True
    return redirect("cart")


# ================= ORDER =================

@login_required
def place_order(request):
    # Get cart from session
    cart = request.session.get('cart', {})

    # Check if cart is empty
    if not cart:
        messages.error(request, "Your cart is empty!")
        return redirect('store_page')

    try:
        # Get customer profile
        customer = Customer.objects.get(user=request.user)

        # First, verify stock availability for all items
        insufficient_stock = []
        order_items = []
        total_amount = 0

        for product_id, quantity in cart.items():
            try:
                product = Product.objects.get(product_id=int(product_id))

                # Check if enough stock is available
                if product.stock_quantity >= quantity:
                    subtotal = float(product.price) * quantity
                    total_amount += subtotal

                    order_items.append({
                        'product': product,
                        'quantity': quantity,
                        'subtotal': subtotal,
                        'price': float(product.price)
                    })
                else:
                    insufficient_stock.append({
                        'product': product,
                        'requested': quantity,
                        'available': product.stock_quantity
                    })
            except Product.DoesNotExist:
                # Remove invalid products from cart
                continue

        # If any items have insufficient stock, show error and don't process order
        if insufficient_stock:
            error_msg = "Some items have insufficient stock: "
            for item in insufficient_stock:
                error_msg += f"{item['product'].product_name} (available: {item['available']}, requested: {item['requested']}), "
            messages.error(request, error_msg.rstrip(', '))
            return redirect('cart')

        # Create Bill record
        bill = Bill.objects.create(
            customer=customer,
            total_amount=total_amount
        )

        # Create BillItem records and deduct stock
        for item in order_items:
            product = item['product']

            # Create bill item
            BillItem.objects.create(
                bill=bill,
                product=product,
                quantity=item['quantity'],
                price_at_time=item['price']
            )

            # Deduct stock
            product.stock_quantity -= item['quantity']
            product.save()

        # Clear the cart after successful order
        del request.session['cart']
        request.session.modified = True

        messages.success(request, f"Order placed successfully! Bill #{bill.bill_number} has been generated.")

        # Show order confirmation page with invoice details
        return render(request, "store/place_order.html", {
            "success": True,
            "order_items": order_items,
            "total": total_amount,
            "bill": bill,
            "customer": customer
        })

    except Customer.DoesNotExist:
        messages.error(request, "Customer profile not found")
        return redirect('customer_dashboard')
    except Exception as e:
        messages.error(request, f"Error placing order: {str(e)}")
        return redirect('cart')


# ================= INVOICE DOWNLOAD =================

@login_required
def download_invoice(request, bill_id):
    try:
        bill = Bill.objects.get(bill_id=bill_id, customer__user=request.user)

        # Generate PDF
        from django.http import HttpResponse
        from .utils import generate_invoice_pdf

        pdf = generate_invoice_pdf(bill)

        response = HttpResponse(pdf, content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="{bill.bill_number}.pdf"'
        return response

    except Bill.DoesNotExist:
        messages.error(request, "Invoice not found")
        return redirect('customer_dashboard')