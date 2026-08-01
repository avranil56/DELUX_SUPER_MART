from django.contrib import admin
from .models import Category, Customer, Product, ProductPermission, Bill, BillItem

admin.site.register(Category)
admin.site.register(Customer)
admin.site.register(Product)
admin.site.register(ProductPermission)
admin.site.register(Bill)
admin.site.register(BillItem)
