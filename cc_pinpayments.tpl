{script src="js/lib/maskedinput/jquery.maskedinput.min.js"}
{script src="js/lib/creditcardvalidator/jquery.creditCardValidator.js"}

{if $payment_data.processor_params.test == 'Y'}
    {script src="https://test-api.pin.net.au/pin.js"}
{else}
    {script src="https://api.pin.net.au/pin.js"}
{/if}
<div class="clearfix">
    <div id="hidden-fields">
        <input type="hidden" name="pin_payments" id="pin_payments" value="true">
    </div>
    <div class="credit-card">
            <div class="control-group">
                <label for="cc_number{$id_suffix}" class="cm-required">{__("card_number")}</label>
                <input id="cc_number{$id_suffix}" size="35" type="text" value="" class="input-text cm-autocomplete-off" />
                <ul class="cc-icons-wrap cc-icons" id="cc_icons{$id_suffix}">
                    <li class="cc-icon cm-cc-default"><span class="default">&nbsp;</span></li>
                    <li class="cc-icon cm-cc-visa"><span class="visa">&nbsp;</span></li>
                    <li class="cc-icon cm-cc-visa_electron"><span class="visa-electron">&nbsp;</span></li>
                    <li class="cc-icon cm-cc-mastercard"><span class="mastercard">&nbsp;</span></li>
                    <li class="cc-icon cm-cc-maestro"><span class="maestro">&nbsp;</span></li>
                    <li class="cc-icon cm-cc-amex"><span class="american-express">&nbsp;</span></li>
                    <li class="cc-icon cm-cc-discover"><span class="discover">&nbsp;</span></li>
                </ul>
            </div>
    
            <div class="control-group">
                <label for="cc_name{$id_suffix}" class="cm-required">{__("valid_thru")}</label>
                <input type="text" id="cc_expiry_month{$id_suffix}" value="" size="2" maxlength="2" class="input-text-short" />&nbsp;&nbsp;/&nbsp;&nbsp;<input type="text" id="cc_expiry_year{$id_suffix}"  value="" size="2" maxlength="2" class="input-text-short" />&nbsp;
            </div>
    
            <div class="control-group">
                <label for="cc_name{$id_suffix}" class="cm-required">{__("cardholder_name")}</label>
                <input id="cc_name{$id_suffix}" size="35" type="text"  value="" class="input-text uppercase" />
            </div>
    </div>
    
    <div class="control-group cvv-field">
        <label for="cc_cvc{$id_suffix}" class="cm-required cm-integer cm-autocomplete-off">{__("cvv2")}</label>
        <input id="cc_cvc{$id_suffix}" type="text" value="" size="4" maxlength="4" class="input-text-short" />

        <div class="cvv2">{__("what_is_cvv2")}
            <div class="cvv2-note">

                <div class="card-info clearfix">
                    <div class="cards-images">
                        <img src="{$images_dir}/visa_cvv.png" alt="" />
                    </div>
                    <div class="cards-description">
                        <h5>{__("visa_card_discover")}</h5>
                        <p>{__("credit_card_info")}</p>
                    </div>
                </div>
                <div class="card-info ax clearfix">
                    <div class="cards-images">
                        <img src="{$images_dir}/express_cvv.png" alt="" />
                    </div>
                    <div class="cards-description">
                        <h5>{__("american_express")}</h5>
                        <p>{__("american_express_info")}</p>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div id="pin_errors">
        <h4 class="description"></h4>
        <ul></ul>
    </div>
</div>

<script type="text/javascript">
(function(_, $) {
    $(document).ready(function() {
        // Default CS-Cart Stuff
        var icons = $('#cc_icons{$id_suffix} li');
        $("#cc_number{$id_suffix}").mask("9999 9999 9999 9?999", {
            placeholder: ' '
        });

        $("#cc_cvv2{$id_suffix}").mask("999?9", {
            placeholder: ''
        });

        $("#cc_exp_month{$id_suffix},#cc_exp_year{$id_suffix}").mask("99", {
            placeholder: ''
        });

        $('#cc_number{$id_suffix}').validateCreditCard(function(result) {
            icons.removeClass('active');
            if (result.card_type) {
                icons.filter('.cm-cc-' + result.card_type.name).addClass('active');

                if (['visa_electron', 'maestro', 'laser'].indexOf(result.card_type.name) != -1) {
                    $('label[for=cc_cvv2{$id_suffix}]').removeClass('cm-required');
                } else {
                    $('label[for=cc_cvv2{$id_suffix}]').addClass('cm-required');
                }
            }
        });

        // We Start Here
        // get the form and submit button - this is workaround with a hidden field since 
        // we can't target form element directly
        form = $('#pin_payments').closest('form');
        form.addClass("pin-payments");
        submit = form.find(":submit");
        pin_errors = $('#pin_errors');

        // Set Publishable Key
        Pin.setPublishableKey("{$payment_data.processor_params.publishable_key}");

        form.submit(function(e){
            // don't submit form yet
            e.preventDefault();
            // hide errors (if any)
            pin_errors.hide();
            // Disable Submit so users don't click twice
            submit.prop("disabled", true);
            // Get card details so we can create a token
            // escaping the curly braces ~ Smarty
            var card = {ldelim}
                number: $('input[id^="cc_number"]').val(),
                name: $('input[id^="cc_name"]').val(),
                expiry_month: $('input[id^="cc_expiry_month"]').val(),
                expiry_year: $('input[id^="cc_expiry_year"]').val(),
                cvc: $('input[id^="cc_cvc"]').val(),
                address_line1: "{$cart.user_data.b_address}",
                address_line2: "{$cart.user_data.b_address_2}",
                address_city: "{$cart.user_data.b_city}",
                address_state: "{$cart.user_data.b_state}",
                address_postcode: "{$cart.user_data.b_zipcode}",
                address_country: "{$cart.user_data.b_country}"
            {rdelim};
            // Create token and handle response from Pin
            Pin.createToken(card, pinResponse);
        });
        
        // Handle Response from Pin Payments
        function pinResponse(response){
            console.log(response); // debugging only
            
            if (response.response) {
                // Add data to the form
                $('<input>').attr({ldelim}type: 'hidden', name: 'pin_card_token'{rdelim}).val(response.response.token).appendTo(form);
                $('<input>').attr({ldelim}type: 'hidden', name: 'pin_ip'{rdelim}).val(response.ip_address).appendTo(form);
                // Submit the form
                form.get(0).submit();

            } else {
                $('.description', pin_errors).text(response.error_description);
                var elist = $('ul', pin_errors);
                if (response.messages) { 
                    $.each(response.messages, function(i, m){ 
                        $('input[id^="cc_'+m.param+'"]').addClass('cm-failed-field xyz');
                        // to do: change to appendTo !!
                        elist.append('<li>'+m.message+'</li>');
                    });
                }
                pin_errors.show();
                // re-enable submit
                submit.prop("disabled", false);
            }
        }
    });
})(Tygh, Tygh.$);
</script>