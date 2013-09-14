<div class="control-group">
    <label class="control-label" for="pp_secret_key">Secret Key:</label>
    <div class="controls">
        <input type="text" name="payment_data[processor_params][secret_key]" id="pp_secret_key" value="{$processor_params.secret_key}"   size="60">
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="pp_publishable_key">Publishable Key:</label>
    <div class="controls">
        <input type="text" name="payment_data[processor_params][publishable_key]" id="pp_publishable_key" value="{$processor_params.publishable_key}"   size="60">
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="pp_order_prefix">Order Prefix:</label>
    <div class="controls">
        <input type="text" name="payment_data[processor_params][order_prefix]" id="pp_order_prefix" value="{$processor_params.order_prefix}"  size="60">
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="pp_test_mode">Sandbox (test mode):</label>
   <div class="controls">
        <select name="payment_data[processor_params][test]" id="pp_test_mode">
           <option value="Y" {if $processor_params.test == "Y"}selected="selected"{/if}>Yes</option>
           <option value="N" {if $processor_params.test == "N"}selected="selected"{/if}>No - live payments</option>
       </select>
   </div>
</div>