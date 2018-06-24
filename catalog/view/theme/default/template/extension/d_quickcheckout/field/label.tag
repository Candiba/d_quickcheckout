<field_label>
    <label_setting if={riot.util.tags.selectTags().search('"label_setting"') && getState().edit} field_id="{opts.field_id}" field="{opts.field}" step="{opts.step}"></label_setting>
    
    <pro_label if={ riot.util.tags.selectTags().search('"label_setting"') < 0 && getState().edit}></pro_label>

    <div if={ (opts.field.display == 1) } class="form-group clearfix field-sortable">
        <div class="col-xs-12">
            <label class="control-label" for="{ opts.step }_{ opts.field.id }">
                { getLanguage()[opts.step][opts.field.text] }
            </label>
            <p id="{ opts.step }_{ opts.field.id }" class="label-text" />
                { opts[opts.step][opts.field.id] }
            </p>
        </div>
    </div>

    <div class="no-display" if={ (opts.field.display != 1 && getState().edit && typeof opts.field.display !== 'undefined') }>
        <label class="col-md-12" >{ getLanguage()[opts.step][opts.field.text] } <div class="pull-right"><span class="label label-warning">{getLanguage().general.text_hidden}<span></div></label>
    </div>

    <script>
        this.setting_id = opts.step +'_'+ opts.field_id +'_setting';

        var tag = this;
    </script>
</field_label>
