# CS-Cart Pin Payments

CS-Cart Pin Payments is a payment module for the [cs-cart](http://www.cs-cart.com) ecommerce platform.

This versions only works with CS-Cart v4.x. This module is also available for CS-Cart v3.x on request.

Pin Payments only supports VISA and MasterCard.

## COMING SOON

##Installation
According to the [Knowledge base](http://kb.cs-cart.com/new-payment) - modified for v4

1. Upload pin_payments.php to /app/payments/
2. Upload pin_payments.tpl to /design/backend/templates/views/payments/components/cc_processors/
4. upload cc_pinpayments.tpl to /design/themes/[TEMPLATE_NAME]/templates/views/orders/components/payments/cc_pinpayments.tpl
3. Insert a record into the cscart_payment_processors database table (content of cs_cart_pinpayments.sql) 
