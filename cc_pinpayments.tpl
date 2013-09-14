{script src="js/lib/maskedinput/jquery.maskedinput.min.js"}
{script src="js/lib/creditcardvalidator/jquery.creditCardValidator.js"}

<div class="clearfix">
    <div class="credit-card">
            <div class="control-group">
                <label for="cc_number{$id_suffix}" class="cm-required">{__("card_number")}</label>
                <input id="cc_number{$id_suffix}" size="35" type="text" name="payment_info[card_number]" value="" class="input-text cm-autocomplete-off" />
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
                <input type="text" id="cc_exp_month{$id_suffix}" name="payment_info[expiry_month]" value="" size="2" maxlength="2" class="input-text-short" />&nbsp;&nbsp;/&nbsp;&nbsp;<input type="text" id="cc_exp_year{$id_suffix}" name="payment_info[expiry_year]" value="" size="2" maxlength="2" class="input-text-short" />&nbsp;
            </div>
    
            <div class="control-group">
                <label for="cc_name{$id_suffix}" class="cm-required">{__("cardholder_name")}</label>
                <input id="cc_name{$id_suffix}" size="35" type="text" name="payment_info[cardholder_name]" value="" class="input-text uppercase" />
            </div>
    </div>
    
    <div class="control-group cvv-field">
        <label for="cc_cvv2{$id_suffix}" class="cm-required cm-integer cm-autocomplete-off">{__("cvv2")}</label>
        <input id="cc_cvv2{$id_suffix}" type="text" name="payment_info[cvv2]" value="" size="4" maxlength="4" class="input-text-short" />

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
</div>

<script type="text/javascript">
(function(_, $) {
    $(document).ready(function() {
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
    });
})(Tygh, Tygh.$);
</script>