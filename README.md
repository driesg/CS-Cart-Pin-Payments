# CS-Cart Pin Payments

CS-Cart Pin Payments is a payment module for the [cs-cart](http://www.cs-cart.com) ecommerce platform.

This versions only works with CS-Cart v4.x. This module is also available for CS-Cart v3.x on request.

Pin Payments only supports VISA and MasterCard.

## Alpha Release ! Works but needs improvements

##Installation
According to the [Knowledge base](http://kb.cs-cart.com/new-payment) - modified for v4

1. Upload pin_payments.tpl to the __/design/backend/templates/views/payments/components/cc_processors/__ directory on your server
2. Upload pin_payments.php to the __/app/payments/__ directory on your server
3. upload cc_pinpayments.tpl to the __/design/themes/[THEME_NAME]/templates/views/orders/components/payments/__ directory on your server
4. Run queries in cscart_pinpayments.sql on cs-cart database (register payment processor and add language variables)
5. Set up new payment method under Administration - Payment Methods
    1. Select Pin Payments as processor
    2. Add the keys under configure