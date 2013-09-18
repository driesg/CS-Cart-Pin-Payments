REPLACE INTO cscart_payment_processors (processor_id, processor, processor_script,processor_template, admin_template, callback, type) values ('1005', 'Pin Payments','pin_payments.php', 'views/orders/components/payments/cc_pinpayments.tpl','pin_payments.tpl', 'Y', 'P');

INSERT INTO cscart_language_values (`lang_code`, `name`, `value`)  SELECT DISTINCT lang_code, 'card_token', 'Card Token' FROM cscart_languages;

# card_token, card_number, card_exp_m, card_exp_y, card_name