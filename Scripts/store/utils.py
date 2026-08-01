from io import BytesIO
from django.http import HttpResponse
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, Image
from reportlab.lib.enums import TA_CENTER, TA_RIGHT
from datetime import datetime


def generate_invoice_pdf(bill):
    """
    Generate a PDF invoice for the given bill
    """
    buffer = BytesIO()

    # Create the PDF document
    doc = SimpleDocTemplate(
        buffer,
        pagesize=A4,
        rightMargin=72,
        leftMargin=72,
        topMargin=72,
        bottomMargin=18,
    )

    # Container for the 'Flowable' objects
    elements = []

    # Get styles
    styles = getSampleStyleSheet()
    styles.add(ParagraphStyle(
        name='CenterTitle',
        parent=styles['Heading1'],
        alignment=TA_CENTER,
        spaceAfter=30,
    ))
    styles.add(ParagraphStyle(
        name='RightAlign',
        parent=styles['Normal'],
        alignment=TA_RIGHT,
    ))

    # Store Details
    store_name = Paragraph('<font size=20><b>DELUX SUPERSTORE</b></font>', styles['Heading1'])
    elements.append(store_name)

    store_address = Paragraph(
        '123 Business Avenue, City - 400001<br/>'
        'GST: 27ABCDE1234F1Z5 | Email: support@deluxstore.com',
        styles['Normal']
    )
    elements.append(store_address)
    elements.append(Spacer(1, 20))

    # Invoice Title and Number
    title = Paragraph(f'<font size=16><b>TAX INVOICE</b></font>', styles['Heading2'])
    elements.append(title)
    elements.append(Spacer(1, 10))

    # Invoice Details Table
    invoice_details = [
        ['Invoice Number:', bill.bill_number, 'Date:', bill.bill_date.strftime('%d-%m-%Y %H:%M')],
    ]

    invoice_table = Table(invoice_details, colWidths=[100, 200, 80, 200])
    invoice_table.setStyle(TableStyle([
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('ALIGN', (0, 0), (0, 0), 'RIGHT'),
        ('ALIGN', (2, 0), (2, 0), 'RIGHT'),
    ]))
    elements.append(invoice_table)
    elements.append(Spacer(1, 20))

    # Customer Details
    customer = bill.customer
    customer_text = f"""
    <b>Bill To:</b><br/>
    {customer.customer_name}<br/>
    Customer ID: CUST{customer.customer_id:04d}<br/>
    Username: {customer.user.username}
    """
    elements.append(Paragraph(customer_text, styles['Normal']))
    elements.append(Spacer(1, 20))

    # Items Table
    table_data = [['#', 'Product', 'Quantity', 'Unit Price', 'Subtotal']]

    for idx, item in enumerate(bill.items.all(), 1):
        table_data.append([
            str(idx),
            item.product.product_name,
            str(item.quantity),
            f'₹{item.price_at_time:.2f}',
            f'₹{item.quantity * item.price_at_time:.2f}'
        ])

    # Add total row
    table_data.append(['', '', '', '<b>Total:</b>', f'<b>₹{bill.total_amount:.2f}</b>'])

    # Create table
    items_table = Table(table_data, colWidths=[40, 250, 80, 100, 100])
    items_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('ALIGN', (3, 1), (3, -2), 'RIGHT'),
        ('ALIGN', (4, 1), (4, -2), 'RIGHT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, -1), (-1, -1), colors.beige),
        ('FONTNAME', (0, -1), (-1, -1), 'Helvetica-Bold'),
        ('GRID', (0, 0), (-1, -2), 1, colors.black),
        ('LINEABOVE', (0, -1), (-1, -1), 2, colors.black),
    ]))

    elements.append(items_table)
    elements.append(Spacer(1, 30))

    # Payment Status
    status_table = Table([['✅ PAID', 'Authorized Signature']], colWidths=[300, 200])
    status_table.setStyle(TableStyle([
        ('ALIGN', (0, 0), (0, 0), 'LEFT'),
        ('ALIGN', (1, 0), (1, 0), 'RIGHT'),
        ('FONTNAME', (0, 0), (0, 0), 'Helvetica-Bold'),
        ('BACKGROUND', (0, 0), (0, 0), colors.green),
        ('TEXTCOLOR', (0, 0), (0, 0), colors.whitesmoke),
    ]))
    elements.append(status_table)
    elements.append(Spacer(1, 20))

    # Footer
    footer = Paragraph(
        '<i>This is a computer generated invoice - No signature required</i><br/>'
        '<b>Thank you for shopping with us! Visit again.</b>',
        styles['Normal']
    )
    elements.append(footer)

    # Build PDF
    doc.build(elements)

    # Get the value of the BytesIO buffer
    pdf = buffer.getvalue()
    buffer.close()

    return pdf