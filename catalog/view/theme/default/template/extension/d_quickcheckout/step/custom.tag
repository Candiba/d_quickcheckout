<custom>
    <div class="step">

        <custom_setting if={riot.util.tags.selectTags().search('"custom_setting"') && getState().edit} step="{opts.step}"></custom_setting>

        <pro_label if={ riot.util.tags.selectTags().search('"custom_setting"') < 0 && getState().edit}></pro_label>

        <!-- Step -->
        <div class="panel panel-default" show={ getConfig().custom.display == 1 }>
            <div class="panel-heading">
                <h4 class="panel-title">
                    <span class="icon">
                        <i class="{ getConfig().custom.icon }"></i>
                    </span>
                    { getLanguage().custom.heading_title }
                </h4>
                <h5 if={getLanguage().custom.text_description}>{  getLanguage().custom.text_description } </h5>
            </div>
            <div id="custom_fields" class="panel-body">
                <div class="row">
                    <div id="custom_fields" class="custom-fields">
                        <div 
                            each={ field_id in fields }
                            if={ (getConfig().custom.fields[field_id])}
                            class="field { (getConfig().custom.fields[field_id].style == 'col') ? 'qc-col' : 'qc-clearboth' }"
                            sort_order={ getConfig().custom.fields[field_id].sort_order }
                            field_id={field_id}
                            step="custom"
                            no-reorder
                            field={ getConfig().custom.fields[field_id] }
                            value={ getSession().custom[field_id] }
                            error={ getError().custom && getError().custom[field_id]}
                            data-is={ getConfig().custom.fields[field_id].type ? 'field_' + getConfig().custom.fields[field_id].type : ''}
                        ></div>
                    </div>
                </div>
                <custom_field if={getState().edit} setting_id="custom_custom_field" step="custom" location_account="true"></custom_field>
            </div>
        </div>

        <!-- Hidden Step -->
        <div show={(getConfig().custom.display != 1 && getState().edit)}>
            <div class="panel panel-default" style="opacity: 0.5">
                <div class="panel-heading"> 
                    { getLanguage().custom.heading_title } 
                    <div class="pull-right"><span class="label label-warning">{getLanguage().general.text_hidden}<span></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        this.setting_id = 'custom_setting';

        var tag = this;

        tag.fields = this.store.getFieldIds('custom');

        this.on('mount', function(){
            this.store.initFieldSortable('custom');
            
        })
    </script>
</custom>
