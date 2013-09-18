REPLACE INTO cscart_payment_processors (processor_id, processor, processor_script,processor_template, admin_template, callback, type) values ('1005', 'Pin Payments','pin_payments.php', 'views/orders/components/payments/cc_pinpayments.tpl','pin_payments.tpl', 'Y', 'P');

-- Language Variables
INSERT INTO cscart_language_values (`lang_code`, `name`, `value`) VALUES ('en', 'card_token', 'Card Token'), ('en', 'card_name', 'Card Name'), ('en', 'card_number', 'Card Number');
