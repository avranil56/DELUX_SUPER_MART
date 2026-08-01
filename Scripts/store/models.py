from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone


class Category(models.Model):
    category_id = models.AutoField(primary_key=True)
    category_name = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'category'

    def __str__(self):
        return self.category_name


class Customer(models.Model):
    customer_id = models.AutoField(primary_key=True)
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        related_name="customer_profile"
    )
    customer_name = models.CharField(max_length=100)
    customer_age = models.IntegerField()
    customer_sex = models.CharField(max_length=1)

    class Meta:
        managed = False
        db_table = 'customer'

    def __str__(self):
        return f"{self.customer_name} ({self.user.username})"


class Product(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_name = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    stock_quantity = models.IntegerField()
    allowed_gender = models.CharField(max_length=3, blank=True, null=True)
    is_adult_only = models.BooleanField(default=False)
    category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE,
        related_name="products"
    )
    # NEW FIELD: Product sprite image (pixel art / animated sprite)
    product_sprite = models.ImageField(
        upload_to='product_sprites/',
        blank=True,
        null=True,
        help_text="Upload product sprite image (pixel art recommended)"
    )

    class Meta:
        managed = False
        db_table = 'product'
        unique_together = ('product_name', 'category')
        ordering = ['product_name']

    def __str__(self):
        return f"{self.product_name} - ₹{self.price}"


class ProductPermission(models.Model):
    permission_id = models.AutoField(primary_key=True)
    category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE,
        related_name="permissions"
    )
    min_age = models.IntegerField(blank=True, null=True)
    max_age = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'product_permission'

    def __str__(self):
        return f"{self.category.category_name} Permission"


class Bill(models.Model):
    bill_id = models.AutoField(primary_key=True)
    bill_number = models.CharField(max_length=20, unique=True, blank=True)
    bill_date = models.DateTimeField(default=timezone.now)
    customer = models.ForeignKey(
        Customer,
        on_delete=models.CASCADE,
        related_name="bills"
    )
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    class Meta:
        managed = True
        db_table = 'bill'
        ordering = ['-bill_date']

    def save(self, *args, **kwargs):
        if not self.bill_number:
            # Generate bill number: INV-YYYYMMDD-XXXX
            date_str = timezone.now().strftime('%Y%m%d')
            last_bill = Bill.objects.filter(bill_number__startswith=f'INV-{date_str}').order_by('-bill_id').first()
            if last_bill:
                last_num = int(last_bill.bill_number.split('-')[-1])
                new_num = str(last_num + 1).zfill(4)
            else:
                new_num = '0001'
            self.bill_number = f'INV-{date_str}-{new_num}'
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.bill_number} - {self.customer.customer_name}"


class BillItem(models.Model):
    bill_item_id = models.AutoField(primary_key=True)
    bill = models.ForeignKey(
        Bill,
        on_delete=models.CASCADE,
        related_name="items"
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE
    )
    quantity = models.IntegerField()
    price_at_time = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = True
        db_table = 'billitem'

    def __str__(self):
        return f"{self.bill.bill_number} - {self.product.product_name} x{self.quantity}"


# NEW MODEL: Hero Images for Store Page Slideshow
class HeroImage(models.Model):
    image_id = models.AutoField(primary_key=True)
    image = models.ImageField(
        upload_to='hero_images/',
        help_text="Upload hero slideshow image (recommended size: 1200x400px)"
    )
    title = models.CharField(max_length=100, blank=True, null=True, help_text="Optional title for the slide")
    subtitle = models.CharField(max_length=200, blank=True, null=True, help_text="Optional subtitle for the slide")
    order = models.IntegerField(default=0, help_text="Order of display (lower numbers appear first)")
    uploaded_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        managed = True
        db_table = 'hero_image'
        ordering = ['order', 'uploaded_at']

    def __str__(self):
        return f"Hero Image {self.image_id} - Order: {self.order}"


# NEW MODEL: Customer Login Tracking for Statistics
class CustomerLogin(models.Model):
    login_id = models.AutoField(primary_key=True)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name="logins")
    login_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        managed = True
        db_table = 'customer_login'
        ordering = ['-login_time']

    def __str__(self):
        return f"{self.customer.customer_name} logged in at {self.login_time}"