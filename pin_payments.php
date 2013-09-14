<?php

use Tygh\Http;
use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

// Switch between test and live API
if ($processor_data['processor_params']['test'] == 'Y') {
	$request_url = 'https://test-api.pin.net.au/1/charges';
} else {
	$request_url = 'https://api.pin.net.au/1/charges';
}
$prefix = $processor_data['processor_params']['order_prefix'];
$pp_secretkey = $processor_data['processor_params']['secret_key'];

$payment_description = 'Products:';
// Products
if (!empty($order_info['items'])) {
	foreach ($order_info['items'] as $v) {
		$payment_description .= (preg_replace('/[^\w\s]/i', '', $v['product']) ."; amount=" . $v['amount'] . ";");
	}
}
// Gift Certificates
if (!empty($order_info['gift_certificates'])) {
	foreach ($order_info['gift_certificates'] as $v) {
		$payment_description .= ($v['gift_cert_code'] ."; amount=1;");
	}
}

// Build the data array
$data = array();
$data['email'] = $order_info['email'];
$data['description'] = $prefix.' order #'.$order_info['order_id'];
$data['amount'] = strval($order_info['total']*100); //cents !
$data['currency'] = 'AUD';
$data['ip_address'] = $order_info['ip_address'];
$card = array(  'number' => $order_info['payment_info']['card_number'],
                'expiry_month' => $order_info['payment_info']['expiry_month'],
                'expiry_year' => '20'.$order_info['payment_info']['expiry_year'], //Dirty, but works for the next 87 years
                'cvc' => $order_info['payment_info']['cvv2'],
                'name' => $order_info['payment_info']['cardholder_name'],
                'address_line1' => $order_info['b_address'],
                'address_city' => $order_info['b_city'],
                'address_postcode' => $order_info['b_zipcode'],
                'address_state' => $order_info['b_state'],
                'address_country' => $order_info['b_country']);
$data['card'] = $card;


// Need to authenticate to make an API call

$http_response =  Http::post($request_url, $data, 
    array( 'basic_auth' => array($pp_secretkey, '')  )
);
Registry::set('log_cut_data', array('name', 'number', 'expiry_month', 'expiry_year', 'cvc'));

$return = json_decode($http_response);

$success = $return->response->success;
$amount = $return->response->amount;
$transaction_id = $return->response->token;

if($success == "true" && fn_format_price($amount) == fn_format_price($order_info['total'] * 100)) {
	$pp_response['order_status'] = 'P';
    $message = $return->response->status_message;
	$pp_response["reason_text"] = $message;

} else {
	$pp_response['order_status'] = 'F';
    $error = $return->messages[0]->message;
	if (!empty($error)) {
		$pp_response["reason_text"] = "Error: " .$error;
	}
}

if (!empty($transaction_id)) {
	$pp_response["transaction_id"] = $transaction_id;
}

?>