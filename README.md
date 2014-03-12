# CS-Cart Pin Payments

CS-Cart Pin Payments is a payment module for the [cs-cart](http://www.cs-cart.com) ecommerce platform.

This versions only works with CS-Cart v4.x. This module is also available for CS-Cart v3.x on request.

Pin Payments only supports VISA and MasterCard.

## Alpha Release ! Works but needs improvements

##Installation
According to the [Knowledge base](http://kb.cs-cart.com/new-payment) - modified for v4

1. Run queries in cscart_pinpayments.sql on cs-cart database (register payment processor and add language variables)
    - via CS-Cart database management
    - or via your  database management tool
2. Upload app and design to your CS-Cart installation to install the files (merge with existing files)
3. Set up new payment method under Administration - Payment Methods
    1. Select Pin Payments as processor
    2. Add the keys under configure

##To Do
- Currencies
- test and live keys ?