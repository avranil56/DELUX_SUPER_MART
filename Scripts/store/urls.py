from django.urls import path
from . import views

urlpatterns = [
    path("register/", views.customer_register, name="register"),
    path("login/", views.user_login, name="login"),
    path("logout/", views.user_logout, name="logout"),
    path("admin-dashboard/", views.admin_dashboard, name="admin_dashboard"),
    path("customer-dashboard/", views.customer_dashboard, name="customer_dashboard"),
    path("add-category/", views.add_category, name="add_category"),
    path("manage-categories/", views.manage_categories, name="manage_categories"),
    path("delete-category/<int:category_id>/", views.delete_category, name="delete_category"),
    path("add-product/", views.add_product, name="add_product"),
    path("manage-products/", views.manage_products, name="manage_products"),
    path("delete-product/<int:product_id>/", views.delete_product, name="delete_product"),
    path("update-stock/<int:product_id>/<str:action>/", views.update_stock, name="update_stock"),
    path("update-price/<int:product_id>/<str:action>/", views.update_price, name="update_price"),
    path("store/", views.store_page, name="store_page"),
    path('place-order/', views.place_order, name='place_order'),
    path('cart/', views.cart_view, name='cart'),
    path("update-cart/<int:product_id>/<str:action>/", views.update_cart, name="update_cart"),
    path('download-invoice/<int:bill_id>/', views.download_invoice, name='download_invoice'),
    path("manage-hero-images/", views.manage_hero_images, name="manage_hero_images"),
    path("delete-hero-image/<int:image_id>/", views.delete_hero_image, name="delete_hero_image"),
    path("admin-statistics/", views.admin_statistics, name="admin_statistics"),
]