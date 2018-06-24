<field_text>

    <text_setting if={riot.util.tags.selectTags().search('"text_setting"') && getState().edit} field_id="{opts.field_id}" field="{opts.field}" step="{opts.step}"></text_setting>

    <pro_label if={ riot.util.tags.selectTags().search('"text_setting"') < 0 && getState().edit}></pro_label>

    <div if={ isVisible() } class="field-sortable form-group clearfix { (opts.error && isRequired()) ? 'has-error' : ''}">
        <label class="{ (getStyle() == 'list') ? 'col-md-6' : 'col-md-12'} control-label" for="{ opts.step }_{ opts.field_id }">
            { getLanguage()[opts.step][opts.field.text] } 
            <span if={ isRequired() } class="require">*</span>
            <i class="fa fa-question-circle" ref="tooltip" data-placement="top" title="{ getLanguage()[opts.step][opts.field.tooltip] } " if={ getLanguage()[opts.step][opts.field.tooltip] }></i>
        </label>
        <div class="{ (getStyle() == 'list') ? 'col-md-6' : 'col-md-12'}">
            <input
                type="text"
                ref="input"
                id="{ opts.step }_{ opts.field_id }"
                name="{ opts.step }[{opts.field_id}]"
                class="form-control validate { (opts.field.require) ? 'required' : 'not-required'} { opts.field.type } { opts.field_id }"
                value="{ opts.riotValue }"
                no-reorder
                autocomplete="{ opts.field.autocomplete }"
                placeholder={ getLanguage()[opts.step][opts.field.placeholder] }
                onchange={ change }
                />
        </div>
        <div class="col-md-12 error" if={opts.error && isRequired()}>
            <div class="text-danger">{ getLanguage()[opts.step][opts.error] }</div>
        </div>
    </div>

    <div class="no-display" if={ (!isVisible() && getState().edit && typeof opts.field.display !== 'undefined') }>
        <label class="col-md-12" >{ getLanguage()[opts.step][opts.field.text] } <div class="pull-right"><span class="label label-warning">{getLanguage().general.text_hidden}<span></div></label>
    </div>

    <script>

        var tag = this;

        isVisible(){
            var field = tag.store.getConfig()[tag.opts.step].fields[tag.opts.field_id];

            for (var depend_field_id in field.depends) {
                
                var field_value = tag.store.getSession()[tag.opts.step][depend_field_id];

                for (var depend_field_value_id in field.depends[depend_field_id]){
                    var depend_field_value = field.depends[depend_field_id][depend_field_value_id].value

                    if(depend_field_value == field_value){
                        return (field.depends[depend_field_id][depend_field_value_id].display == 1)
                    }
                }

            }

            return tag.store.getConfig()[tag.opts.step].fields[tag.opts.field_id].display == 1;
        }

        isRequired(){
            var field = tag.store.getConfig()[tag.opts.step].fields[tag.opts.field_id];

            for (var depend_field_id in field.depends) {
                
                var field_value = tag.store.getSession()[tag.opts.step][depend_field_id];

                for (var depend_field_value_id in field.depends[depend_field_id]){
                    var depend_field_value = field.depends[depend_field_id][depend_field_value_id].value

                    if(depend_field_value == field_value){
                        return (field.depends[depend_field_id][depend_field_value_id].require == 1)
                    }
                }

            }

            return tag.store.getConfig()[tag.opts.step].fields[tag.opts.field_id].require == 1;
        }

        change(e){
            error = this.store.validate($(e.currentTarget).val(), this.opts.field.errors);
            this.store.dispatch(this.opts.step+'/error', { 'field_id' : this.opts.field_id, 'error': error});
            this.store.dispatch(this.opts.step+'/update', $(e.currentTarget).serializeJSON());
        }

        getStyle(){
            var field = tag.store.getConfig()[tag.opts.step].fields[tag.opts.field_id];
            return field.style;
        }

        initMask(){
            if(this.opts.field.mask){
                $('#' + this.opts.step + '_' + this.opts.field_id).mask(this.opts.field.mask);
            }else{
                $('#' + this.opts.step + '_' + this.opts.field_id).unmask();
            }
        }

        initTooltip(){
            $(this.refs.tooltip).tooltip('destroy')
            setTimeout(function(){
                $(this.refs.tooltip).tooltip();
            }.bind(this), 300)
        }

        this.on('mount', function(){
            this.initMask();
            this.initTooltip();

        })

        this.on('updated', function(){
            this.initMask();
            this.initTooltip();
            
        })
    </script>
</field_text>
