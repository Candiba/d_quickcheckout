{{ header }}{{ column_left }}
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="form-inline pull-right">
                {% if stores|length >1 %}
                <select class="form-control" onChange="location = '{{ module_link }} & store_id=' + $(this).val()">
                    {% for store in stores %}
                        {% if store.store_id  ==  store_id %} 
                            <option value="{{ store.store_id }}" selected="selected" >{{ store.name }}</option>
                        {% else %}  
                            <option value="{{ store.store_id }}" >{{ store.name }}</option>
                        {% endif %} 
                    {% endfor %}
                     
                </select>
                 {% endif %}
                <button id="save_and_stay" data-toggle="tooltip" title="{{ button_save_and_stay }}" class="btn btn-success"><i class="fa fa-save"></i></button>
                <button type="submit" form="form" data-toggle="tooltip" title="{{ button_save }}" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="{{ cancel }}" data-toggle="tooltip" title="{{ button_cancel }}" class="btn btn-default"><i class="fa fa-reply"></i></a>
            </div>
            <h1>{{ heading_title }} {{ version }}</h1>
            <ul class="breadcrumb">
                {% for breadcrumb in breadcrumbs %} 
                <li><a href="{{ breadcrumb.href }}">{{ breadcrumb.text }}</a></li>
                {% endfor %} 
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        {% if error.warning %}
        <div class="alert alert-danger">
            <i class="fa fa-exclamation-circle"></i> {{ error.warning }}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        {% endif %} 
        {% if error.shopunity %}
        <div class="alert alert-danger">
            <i class="fa fa-exclamation-circle"></i>
           {{ error.shopunity }}
        </div>
        {% endif %} 
        {% if success %} 
        <div class="alert alert-success">
            <i class="fa fa-exclamation-circle"></i> {{ success }}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        {% endif %} 

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> {{ text_edit }} {{ setting_name }}</h3>
            </div>
            <div class="panel-body">
                <form action="{{ action }}" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">

                    <ul  class="nav nav-tabs">
                        <li class="active">
                            <a href="#setting" data-toggle="tab">
                                <span class="fa fa-cog"></span>
                               {{ tab_setting }}
                            </a>
                        </li>
                        {% if debug %} 
                        <li>
                            <a href="#debug" data-toggle="tab">
                                <span class="fa fa-bug"></span>
                               {{ tab_debug }}
                            </a>
                        </li>
                        {% endif %} 
                        {% if setting.support %}
                        <li>
                            <a href="#support" data-toggle="tab">
                                <span class="fa fa-support"></span>
                               {{ tab_support }}
                            </a>
                        </li>
                        {% endif %} 
                        <li>
                            <a href="#instruction" data-toggle="tab">
                                <span class="fa fa-graduation-cap"></span>
                               {{ tab_instruction }}
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane active" id="setting" >
                            <div class="tab-body">
                                <div class="row">
                                    <div class="col-sm-2">
                                        <ul class="nav nav-pills s-nav-stacked">
                                            <li class="active">
                                                <a href="#d_home" data-toggle="tab">
                                                    <span class="fa fa-home fa-fw"></span> <span>{{ text_home }}</span>
                                                </a>
                                            </li>
                                            {% if setting_id %}
                                            <li>
                                                <a href="#d_general" data-toggle="tab">
                                                    <i class="fa fa-cog fa-fw"></i> <span>{{ text_general }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_login" data-toggle="tab">
                                                    <i class="fa fa-key fa-fw"></i> <span>{{ text_login }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_payment_address" data-toggle="tab">
                                                    <i class="fa fa-book fa-fw"></i> <span>{{ text_payment_address }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_shipping_address" data-toggle="tab">
                                                    <i class="fa fa-book fa-fw"></i> <span>{{ text_shipping_address }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_shipping_method" data-toggle="tab">
                                                    <i class="fa fa-truck fa-fw"></i> <span>{{ text_shipping_method }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_payment_method" data-toggle="tab">
                                                    <i class="fa fa-credit-card fa-fw"></i> <span>{{ text_payment_method }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_confirm" data-toggle="tab">
                                                    <i class="fa fa-shopping-cart fa-fw"></i> <span>{{ text_cart }} & {{ text_confirm }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_design" data-toggle="tab">
                                                    <i class="fa fa-paint-brush fa-fw"></i> <span>{{ text_design }}</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#d_analytics" data-toggle="tab">
                                                    <i class="fa fa-bar-chart fa-fw"></i> <span>{{ text_analytics }}</span>
                                                </a>
                                            </li>
                                           {% endif %}
                                        </ul>
                                    </div>
                                    <div class="col-sm-10">
                                        <div class="tab-content">

                                        <div id="d_home" class="tab-pane active">
                                                <div class="page-header">
                                                    <h3><span class="fa fa-home"></span> <span>{{ text_home }}</span></h3>
                                                </div>
                                                {% if not settings %} 
                                                <div class="bs-callout bs-callout-warning">{{ text_intro_create_setting }}</div>
                                                {% endif %} 
                                                <div class="row">
                                                    {% for setting_value in settings %}
                                                    <div id="setting_id_{{ setting_value.setting_id }}" class="col-lg-3 col-md-4 col-sm-6 ">
                                                        <div class="tile {{setting_value.setting_id ==  setting_id ? 'selected' : '' }}">
                                                            <a href="#" class="view-setting " data-setting-id="{{ setting_value.setting_id }}" >
                                                                <div class="tile-heading clearfix">
                                                                   {{ setting_value.name }}
                                                                    <span class="pull-right" data-toggle="tooltip" title="{{ help_average_time }}" >{{ ((setting_value.average_checkout_time / 100 )|round() )|date("H:i:s") }}</span>
                                                                </div>
                                                                <div class="tile-body">
                                                                    <a href="{{ setting_value.href }} " target="_blank" data-toggle="tooltip" title="{{ help_view_shop }}"><i class="fa fa-eye"></i></a>
                                                                    <a href="#" class="view-setting " data-setting-id="{{ setting_value.setting_id }}" data-toggle="tooltip" title="{{ help_view_setting }}"><i class="fa fa-pencil"></i></a>
                                                                    <h3 class="pull-right" data-toggle="tooltip" title="{{ help_average_rating }}">{{(setting_value.average_rating * 100)|round() }}%</h3>
                                                                </div>
                                                            </a>
                                                            <div class="tile-footer form-inline clearfix">
                                                                <div class="">
                                                                   {{ text_probability }}:
                                                                    <div class="input-group pull-right probability">
                                                                        <span class="input-group-btn probability-down">
                                                                            <button class="btn btn-default btn-sm " type="button"><i class="fa fa-chevron-down"></i></button>
                                                                        </span>
                                                                        <input type="text" style="width:50px; text-align:center" class="form-control input-sm probability-value" name="{{ id }}_setting_cycle[{{ setting_value.setting_id }}]" value="{{ setting_cycle.setting_value.setting_id ? setting_cycle.setting_value.setting_id : '' }}1  " aria-describedby="sizing-addon2" />
                                                                        <span class="input-group-btn probability-up">
                                                                            <button class="btn btn-default btn-sm " type="button"><i class="fa fa-chevron-up"></i></button>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    {% endfor %}
                                                    <script>
                                                                $('.probability .probability-down').on('click', function(){
                                                        $(this).next().val($(this).next().val() - 1);
                                                                $('.probability-value').trigger('change');
                                                        })
                                                                $('.probability .probability-up').on('click', function(){
                                                        $(this).prev().val(Number($(this).prev().val()) + 1);
                                                                $('.probability-value').trigger('change');
                                                        })

                                                                $('.probability-value').on('change', function(){
                                                        if ($(this).val() < 0){
                                                        $(this).val(0)
                                                        }
                                                        })
                                                    </script>
                                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                                        <div class="tile">
                                                            <div class="tile-heading">
                                                               {{ text_create_setting_heading }}
                                                            </div>
                                                            <a href="#" id="create_setting" class="create-setting" >
                                                                <div class="tile-body">
                                                                    <i class="fa fa-plus"></i>
                                                                    <h3 class="pull-right">{{ text_create_setting }}</h3>
                                                                </div>
                                                            </a>
                                                            <div class="tile-footer">
                                                               {{ text_create_setting_probability }}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <hr/>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input_status">{{ entry_status }}</label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" value="0" name="{{ id }}_status" id="input_status" class="form-control" />
                                                                <input type="checkbox"  value="1" name="{{ id }}_status" id="input_status" {% if attribute(_context,id~'_status') %}  checked="checked" {% endif %} class="form-control" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_trigger }}">
                                                                   {{ entry_trigger }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-8">
                                                                <input type="text" value="{{ attribute(_context,id~'_trigger') }}" name="{{ id }}_trigger" id="trigger" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input_debug">{{ entry_debug }}</label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" name="{{ id }}_debug" value="0" />
                                                                <input type="checkbox" id="input_debug" name="{{ id }}_debug" {{ debug ? 'checked="checked"': ''}} value="1" />
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <script>
                                                $('.tab-content a[data-toggle]').click(function(){
                                                    $('.panel .nav-stacked li.active').removeClass('active')
                                                    $('.panel .nav-stacked li a[href="' + $(this).attr('href') + '"]').parent().addClass('active')
                                                    
                                                })
                                            </script>


                                        <div id="d_general" class="tab-pane">

                                                <h3 class="page-header">
                                                    <span class="fa fa-cog fa-fw"></span> <span>{{ text_general }}</span>
                                                </h3>

                                                <div class="row">
                                                    <div class="col-md-6">

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input_setting_name">
                                                                <span data-toggle="tooltip" title="{{ help_name }}">
                                                                   {{ entry_name }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-8">
                                                                <input type="text" value="{{ setting_name }}" name="{{ id }}_setting[name]" id="input_setting_name" class="form-control"/>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_general_clear_session }}">
                                                                   {{ entry_general_clear_session }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" value="0" name="{{ id }}_setting[general][clear_session]" />
                                                                <input type="checkbox" value="1" name="{{ id }}_setting[general][clear_session]" {% if setting.general.clear_session  and  setting.general.clear_session  ==  1 %} checked="checked"{% endif %}  id="general_clear_session" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_general_login_refresh }}">
                                                                   {{ entry_general_login_refresh }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" value="0" name="{{ id }}_setting[general][login_refresh]" />
                                                                <input type="checkbox" value="1" name="{{ id }}_setting[general][login_refresh]" {% if setting.general.login_refresh  and  setting.general.login_refresh  ==  1 %} checked="checked"{% endif %}  id="general_login_refresh" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_general_analytics_event }}">
                                                                   {{ entry_general_analytics_event }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-2">
                                                                <input type="hidden" value="0" name="{{ id }}_setting[general][analytics_event]" />
                                                                <input type="checkbox" value="1" name="{{ id }}_setting[general][analytics_event]" {% if setting.general.analytics_event  and  setting.general.analytics_event  ==  1 %} checked="checked"{% endif %}  id="general_analytics_event" />
                                                            </div>
                                                            <script>
                                                                $("#general_analytics_event").on('switchChange.bootstrapSwitch', function(event, state){
                                                                    if (state){
                                                                        if ( {{ analytics ? 0 : 1 }} ){
                                                                            $("#analytics_message").removeClass('hidden');
                                                                        }
                                                                    } else{
                                                                        $("#analytics_message").addClass('hidden');
                                                                    }
                                                                })
                                                            </script>
                                                            <div class="col-sm-6">
                                                                <div id="analytics_message" class="alert alert-danger alert-inline    {% if setting.general.analytics_event  !=  1  or   setting.general.analytics_event  ==  1  and  analytics%} {{   'hidden'  }}{% endif %} "  >{{ warning_analytics_event }}</div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_general_update_mini_cart }}">
                                                                   {{ entry_general_update_mini_cart }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" value="0" name="{{ id }}_setting[general][update_mini_cart]" />
                                                                <input type="checkbox" value="1" name="{{ id }}_setting[general][update_mini_cart]" {% if setting.general.update_mini_cart  and  setting.general.update_mini_cart  ==  1 %} checked="checked"{% endif %}  id="general_update_mini_cart" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_general_compress }}">
                                                                   {{ entry_general_compress }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-4">
                                                                <input type="hidden" value="0" name="{{ id }}_setting[general][compress]" />
                                                                <input type="checkbox" value="1" name="{{ id }}_setting[general][compress]" {% if setting.general.compress  and  setting.general.compress  ==  1 %} checked="checked"{% endif %}  id="general_compress" />
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <button class="btn btn-primary btn-block" id="compress_update"><i class="fa fa-refresh"></i> {{ compress_update }}</button>
                                                            </div>
                                                            <div id="compress-notification" class="col-sm-offset-4 help-block col-sm-8" >
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="col-md-6">

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_general_min_order }}">
                                                                   {{ entry_general_min_order }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group">
                                                                    <label for="general_min_order_value" id="label_general_min_order_value" class="input-group-addon">%s</label>
                                                                    {% if setting.general.min_order.value  and  setting.general.min_order.value  !=  "" %} 
                                                                    <input type="text" value="{{ setting.general.min_order.value }}" name="{{ id }}_setting[general][min_order][value]" id="general_min_order_value" class="form-control"/>
                                                                    {% else %}  
                                                                    <input type="text" value="0" name="{{ id }}_setting[general][min_order][value]" class="form-control" id="general_min_order_value"/>
                                                                    {% endif %}
                                                                </div>

                                                                {% for language in languages %} 
                                                                <div id="tab_general_min_order_text_{{ language.language_id }}" class="input-group">
                                                                    <label class="input-group-addon" for="general_min_order_text_{{ language.language_id }}" title="{{ language.name }}"><img src="{{ language.flag }}" title="{{ language.name }}" /></label>
                                                                    <input type="text" name="{{ id }}_setting[general][min_order][text][{{ language.language_id }}]" id="general_min_order_text_{{ language.language_id }}" value="{{ setting.general.min_order.text[language.language_id] ? setting.general.min_order.text[language.language_id] : text_value_min_order }}  " class="form-control" >
                                                                </div>
                                                                {% endfor %} 
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="input-catalog-limit">
                                                                <span data-toggle="tooltip" title="{{ help_general_min_quantity }}">
                                                                   {{ entry_general_min_quantity }}
                                                                </span>
                                                            </label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group">
                                                                    <label for="general_min_quantity_value" id="label_general_min_quantity_value" class="input-group-addon">%s</label>
                                                                    {% if setting.general.min_quantity.value  and  setting.general.min_quantity.value  !=  ""%} 
                                                                    <input type="text" value="{{ setting.general.min_quantity.value }}" name="{{ id }}_setting[general][min_quantity][value]" id="general_min_quantity_value" class="form-control"/>
                                                                    {% else %}  
                                                                    <input type="text" value="0" name="{{ id }}_setting[general][min_quantity][value]" class="form-control" id="general_min_quantity_value"/>
                                                                     {% endif %}
                                                                </div>

                                                                {% for language in languages %} 
                                                                <div id="tab_general_min_quantity_text_{{ language.language_id }}" class="input-group">
                                                                    <label class="input-group-addon" for="general_min_quantity_text_{{ language.language_id }}" title="{{ language.name }}"><img src="{{ language.flag }}" title="{{ language.name }}" /></label>
                                                                    <input type="text" name="{{ id }}_setting[general][min_quantity][text][{{ language.language_id }}]" id="general_min_quantity_text_{{ language.language_id }}" value="{{ setting.general.min_quantity.text[language.language_id] ? setting.general.min_quantity.text[language.language_id] : text_value_min_quantity }} " class="form-control" >
                                                                </div>
                                                                {% endfor %} 
                                                            </div>
                                                        </div>

                                                        {% if config_files %} 
                                                            <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="select_config">{{ entry_config_files }}</label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group">
                                                                    <select id="select_config"  class="form-control" name="{{ id }}_setting[general][config]">
                                                                        {% for config_file in config_files %} 
                                                                        <option value="{{ config_file }}" {{ config_file  ==  config ? 'selected="selected"' : ''}} >{{ config_file }}</option>
                                                                        {% endfor %}
                                                                        {% endif %} 
                                                                    </select>
                                                                    <span class="input-group-btn">
                                                                        <button class="btn btn-primary" id="select_config_submit" type="button">Apply</button>
                                                                    </span>
                                                                </div>

                                                            </div>
                                                            </div>
                                                         
                                                      

                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="button_delete_setting">{{ entry_delete_setting }}</label>
                                                            <div class="col-sm-4">
                                                                <a onclick="confirm('{{ text_confirm_delete_setting }}') ? location.href = '{{ delete_setting }}' : false;" id="button_delete_setting" class="btn btn-primary btn-block"><i class="fa fa-trash-o"></i> {{ button_delete_setting }}</a>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <hr/>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label" for="button_delete_setting">
                                                        <span data-toggle="tooltip" title="{{ help_action_bulk_setting }}">
                                                           {{ entry_action_bulk_setting }}
                                                        </span>
                                                    </label>
                                                    <div class="col-sm-2">
                                                        <button class="btn btn-primary btn-block" id="generate_setting"><i class="fa fa-cog"></i> {{ button_create_bulk_setting }}</button>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <button class="btn btn-primary btn-block" id="save_bulk_setting"><i class="fa fa-floppy-o"></i> {{ button_save_bulk_setting }}</button>
                                                    </div>
                                                    <div class="col-sm-6" id="notification_setting">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label" for="button_delete_setting">
                                                        <span data-toggle="tooltip" title="{{ help_bulk_setting }}">
                                                           {{ entry_bulk_setting }}
                                                        </span>
                                                    </label>
                                                    <div class="col-sm-10">
                                                        <textarea id="bulk_setting" class="form-control"></textarea>
                                                    </div>
                                                </div>

                                            </div>

									        <div id="d_login" class="tab-pane">
									          
									         	<h3 class="page-header">
									         		<span class="fa fa-key fa-fw"></span> <span>{{ text_login }}</span>
									         	</h3>
												<div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
									         	{% if (social_login) %} 
													<div class="form-group">
														<label class="col-sm-3 control-label" for="input-catalog-limit">
															<span data-toggle="tooltip" title="{{ help_social_login }}">
																{{ entry_social_login }} 
															</span>
														</label>
														<div class="col-sm-9">
															<input type="hidden" value="0" name="{{ id }}_setting[general][social_login]" />
															<input type="checkbox" value="1" name="{{ id }}_setting[general][social_login]" {% if (setting['general']['social_login'] is defined and setting['general']['social_login'] == 1) %}checked="checked"{% endif %} id="social_login" />
														</div>
													</div>

													<div class="form-group">
														<div class="col-sm-offset-3 col-sm-9">
															<a href="{{ link_social_login_edit }}" class="btn btn-primary"><i class="fa fa-pencil"></i> {{ button_social_login_edit}}</a>
														</div>
													</div> 
									        	{% else %} 
													<div class="bs-callout bs-callout-warning">{{ text_social_login_required }}</div>
									        	{% endif %} 

											</div>


											<div id="d_payment_address" class="tab-pane">

												<h3 class="page-header">
													<span class="fa fa-book fa-fw"></span> <span>{{ text_payment_address }}</span>
												</h3>
												 <div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
												 
											</div>


											<div id="d_shipping_address" class="tab-pane">

												<h3 class="page-header">
													<span class="fa fa-book fa-fw"></span> <span>{{ text_shipping_address }}</span>
												</h3>
												<div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
												
											</div>


											<div id="d_shipping_method" class="tab-pane">

												<h3 class="page-header">
													<span class="fa fa-truck fa-fw"></span> <span>{{ text_shipping_method }}</span>
												</h3>
												<div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
												
											</div>
									   
											<div id="d_payment_method" class="tab-pane">

												<h3 class="page-header">
													<span class="fa fa-credit-card fa-fw"></span> <span>{{ text_payment_method }}</span>
												</h3>
												<div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
											</div>

											<div id="d_confirm" class="tab-pane">

												<h3 class="page-header">
													<span class="fa fa-shopping-cart fa-fw"></span> <span>{{ text_cart }}</span>
												</h3>
												<div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
												
											</div>


											<div id="d_design" class="tab-pane">

												<h3 class="page-header">
													<span class="fa fa-paint-brush fa-fw"></span> <span>{{ text_design }}</span>
												</h3>
												 <div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
												 
											</div>

											<div id="d_analytics" class="tab-pane">
												
													<h3 class="page-header">
														<span class="fa fa-bar-chart fa-fw"></span> <span>{{ text_analytics }}</span>
													</h3>
													 <div class="bs-callout bs-callout-warning">{{ text_need_full_version }}</div>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>


<div class="tab-pane" id="debug" >
                            <div class="tab-body">
                                <textarea id="textarea_debug_log" wrap="off" rows="15" readonly="readonly" class="form-control">{{ debug_log }}</textarea>
                                <br/>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input_debug_file">{{ entry_debug_file }}</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="input_debug_file" name="{{ id }}_debug_file" value="{{ debug_file }}"  class="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-10 col-sm-offset-2">
                                        <a class="btn btn-danger" id="clear_debug_file">{{ button_clear }}</a>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="tab-pane" id="support" >
                            <div class="tab-body">
                            </div>
                        </div>

                        <div class="tab-pane" id="instruction" >
                            <div class="tab-body">
                               {{ text_instruction }}
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
    {% set column_1 = setting.design.column_width[1] / 12 * 100 %}
    {% set column_2 = setting.design.column_width[2] / 12 * 100 %}
    {% set column_3 = setting.design.column_width[3] / 12 * 100 %}
    {% set column_4 = column_2 + column_3 %}


<style>
    #column_width_1,
    #column_1{
        width: {{ column_1 }}%;
    }
    #column_width_2,
    #column_2{
        width: {{ column_2 }}%;
    }
    #column_width_3,
    #column_3{
        width: {{ column_3 }}%;
    }

    #column_4{
        width: {{ column_4 }}%
    }
</style>

<script type="text/javascript"><!--
    $('#column_slider').slider({
        'tooltip': 'hide'
    }).on('slide', function(ev){
        var val1 = Number(ev.value[0]);
        var pos1 = (val1 / 12) * 100;
        var val2 = Number(ev.value[1]);
        var pos2 = (val2 / 12) * 100;
        $("#column_1, #column_width_1").css({'width' : pos1+'%'})
        $("#column_width_1").val(val1)
        $("#column_2, #column_width_2").css({'width' : pos2-pos1 +'%'})
        $("#column_width_2").val(val2 - val1)
        $("#column_3, #column_width_3").css({'width' : Number(100-pos2) +'%'})
        $("#column_width_3").val(Number(12 - val2))
        $("#column_4").css({'width' : Number(100 - pos1) +'%'})
        $("#column_width_4").val(Number(12 - val1))
        console.log(ev.value[0])
        console.log($('#form').serializeArray())
    })
    var adjustment;
    var group = $("#column_groups ul.column").sortable({
        group: 'column',
        pullPlaceholder: false,
        // animation on drop
        onDrop: function  (item, targetContainer, _super) {
            var clonedItem = $('<li/>').css({height: 0})
            item.before(clonedItem)
            clonedItem.animate({'height': item.height()})
            item.animate(clonedItem.position(), function  () {
                clonedItem.detach()
                _super(item)
            })
            console.log($('#form').serializeArray())
            var data = group.sortable("serialize").get();
            var jsonString = JSON.stringify(data, null, ' ');
            $.each(data, function(column, column_value) {
                $.each(column_value, function(row, row_value) {
                    console.log(row_value['id'] + ' column: ' + column + 1 + 'row: ' + row)
                    $('#step_' + row_value['id'] + ' .data-column').val(column + 1)
                    $('#step_' + row_value['id'] + ' .data-row').val(row)
                });
            });
        },
        // set item relative to cursor position
        onDragStart: function ($item, container, _super) {
            var offset = $item.offset(),
                    pointer = container.rootGroup.pointer

            adjustment = {
                left: pointer.left - offset.left,
                top: pointer.top - offset.top
            }

            _super($item, container)
        },
        onDrag: function ($item, position) {
            $item.css({
                left: position.left - adjustment.left,
                top: position.top - adjustment.top
            })
        }
    })

    $('.sortable > tr').tsort({attr:'sort-data'});
    $(function () {
        $("[type='checkbox']").bootstrapSwitch({
            'onColor': 'success',
            'onText': '{{ text_yes}}',
            'offText': '{{ text_no }}',
        });
        $('[data-toggle="popover"]').popover()

        $('.qc-step').each(function(){
            $(this).appendTo('.qc-col-' + $(this).attr('data-col'));
            })
        $('.qc-step').tsort({attr:'data-row'});
        $(".table-sortable").sortable({
            containerSelector: 'table',
            itemPath: '',
            itemSelector: 'tr',
            distance: '10',
            pullPlaceholder: false,
            placeholder: '<tr class="placeholder"><td colspan="5" /></tr>',
            onDragStart: function (item, container, _super) {
                var offset = item.offset(),
                        pointer = container.rootGroup.pointer

                adjustment = {
                    left: pointer.left - offset.left,
                    top: pointer.top - offset.top
                }

                _super(item, container)
            },
            onDrag: function (item, position) {
                item.css({
                    left: position.left - adjustment.left,
                    top: position.top - adjustment.top
                })
            },
            onDrop: function  (item, container, _super) {
                item.closest('tbody').find('tr').each(function (i, row) {
                    console.log(i)
                    $(row).find('.sort').val(i)

                })

                _super(item)
            }
        })

        $('#select_config_submit').on('click', function(){
            var config = $('#select_config').val();
            var setting_id = '{{ setting_id }}';
            var store_id = '{{ store_id }}';
            $('#content').append('<form action="{{ module_link }}{{ stores ? "&store_id=' + store_id + '" : '' }} {{ setting_id ? "&setting_id=' + setting_id + '" : '' }} " id="config_update" method="post" style="display:none;"><input type="text" name="config" value="' + config + '" /><input type="text" name="setting_id" value="' + setting_id + '" /></form>');
            $('#config_update').submit();
        })

        $('body').on('click', '#save_and_stay', function(){
            $.ajax({
                type: 'post',
                url: $('#form').attr('action') + '&save',
                data: $('#form').serialize(),
                beforeSend: function() {
                    $('#form').fadeTo('slow', 0.5);
                },
                complete: function() {
                    $('#form').fadeTo('slow', 1);
                },
                success: function(response) {
                    console.log(response);
                }
            });
        });
        $('body').on('click', '#button_update', function(){
            $.ajax({
                url: '{{ update }}',
                type: 'post',
                dataType: 'json',
                beforeSend: function() {
                    $('#button_update').find('.fa-refresh').addClass('fa-spin');
                },
                complete: function() {
                    $('#button_update').find('.fa-refresh').removeClass('fa-spin');
                },
                success: function(json) {
                    console.log(json);
                    if (json['error']){
                        $('#notification_update').html('<div class="alert alert-danger m-b-none">' + json['error'] + '</div>')
                    }

                    if (json['warning']){
                        $html = '';
                        if (json['update']){
                            $.each(json['update'], function(k, v) {
                                $html += '<div>Version: ' + k + '</div><div>' + v + '</div>';
                            });
                        }
                        $('#notification_update').html('<div class="alert alert-warning alert-inline">' + json['warning'] + $html + '</div>')
                    }

                    if (json['success']){
                        $('#notification_update').html('<div class="alert alert-success alert-inline">' + json['success'] + '</div>')
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });
        $('body').on('click', '#clear_debug_file', function(){
            $.ajax({
                url: '{{ clear_debug_file }}',
                type: 'post',
                dataType: 'json',
                data: 'debug_file={{ debug_file }}',
                beforeSend: function() {
                    $('#form').fadeTo('slow', 0.5);
                },
                complete: function() {
                    $('#form').fadeTo('slow', 1);
                },
                success: function(json) {
                    $('.alert').remove();
                    console.log(json);
                    if (json['error']){
                        $('#debug .tab-body').prepend('<div class="alert alert-danger">' + json['error'] + '</div>')
                    }

                    if (json['success']){
                        $('#debug .tab-body').prepend('<div class="alert alert-success">' + json['success'] + '</div>')
                        $('#textarea_debug_log').val('');
                    }
                }
            });
        });

        $('body').on('click', '.view-setting', function(){
            var setting_id = $(this).attr('data-setting-id');
            location.href = updateURLParameter($(location).attr('href'), 'setting_id', setting_id);
            return false;
        });
        $('body').on('click', '#create_setting', function(){
            $.ajax({
                url: '{{ create_setting }}',
                type: 'post',
                dataType: 'json',
                data:  $('#form').serialize(),
                beforeSend: function() {
                    $('#form').fadeTo('slow', 0.5);
                },
                complete: function() {
                    $('#form').fadeTo('slow', 1);
                },
                success: function(json) {
                    $('.alert').remove();
                    console.log(json);
                    if (json['error']){
                        $('#content > .container-fluid').prepend('<div class="alert alert-warning">' + json['error'] + '</div>')
                    }

                    if (json['redirect']){
                        location.href = json['redirect'];
                    }
                }
            });
            return false;
        });
        $('body').on('click', '#generate_setting', function () {
            $('#bulk_setting').val(JSON.stringify($('#form').serializeObject().{{ id }}_setting));
            return false;
        })

        $('body').on('click', '#compress_update', function (e) {
            $.ajax({
                url: 'index.php?route=extension/module/d_quickcheckout/updateCompress&user_token={{ token }}',
                type: 'post',
                dataType: 'json',
                data: 'setting_id={{ setting_id }}&setting=' + $('#bulk_setting').val(),
                beforeSend: function () {
                    $('#form').fadeTo('slow', 0.5);
                },
                complete: function () {
                    $('#form').fadeTo('slow', 1);
                },
                success: function (json) {
                    $('.alert').remove();
                    console.log(json);
                    if (json['success']) {
                        $('#compress-notification').prepend('<div class="alert alert-success alert-inline">' + json['success'] + '</div>')
                    }
                    if (json['error']) {
                        $('#compress-notification').prepend('<div class="alert alert-warning alert-inline">' + json['error'] + '</div>')
                    }
                }
            });
            e.preventDefault();
        });
        $('body').on('click', '#save_bulk_setting', function () {
            $.ajax({
                url: '{{ save_bulk_setting }}',
                type: 'post',
                dataType: 'json',
                data: 'setting_id={{ setting_id }}&setting=' + $('#bulk_setting').val(),
                beforeSend: function () {
                    $('#form').fadeTo('slow', 0.5);
                },
                complete: function () {
                    $('#form').fadeTo('slow', 1);
                },
                success: function (json) {
                    $('.alert').remove();
                    console.log(json);
                    if (json['error']) {
                        $('#notification_setting').prepend('<div class="alert alert-warning alert-inline">' + json['error'] + '</div>')
                    }

                    if (json['redirect']) {
                        location.href = json['redirect'];
                    }
                }
            });
            return false;
        });
    });

    function updateURLParameter(url, param, paramVal) {
        var TheAnchor = null;
        var newAdditionalURL = "";
        var tempArray = url.split("?");
        var baseURL = tempArray[0];
        var additionalURL = tempArray[1];
        var temp = "";
        if (additionalURL) {
            var tmpAnchor = additionalURL.split("#");
            var TheParams = tmpAnchor[0];
            TheAnchor = tmpAnchor[1];
            if (TheAnchor)
                additionalURL = TheParams;
            tempArray = additionalURL.split("&");
            for (i = 0; i < tempArray.length; i++) {
                if (tempArray[i].split('=')[0] != param) {
                    newAdditionalURL += temp + tempArray[i];
                    temp = "&";
                }
            }
        }
        else {
            var tmpAnchor = baseURL.split("#");
            var TheParams = tmpAnchor[0];
            TheAnchor = tmpAnchor[1];
            if (TheParams)
                baseURL = TheParams;
        }

        if (TheAnchor)
            paramVal += "#" + TheAnchor;
        var rows_txt = temp + "" + param + "=" + paramVal;
        return baseURL + "?" + newAdditionalURL + rows_txt;
    }

    $('body').on('change', '#payment_address_country_id_input select', function () {
        $.ajax({
            url: 'index.php?route=extension/module/d_quickcheckout/getZone&user_token={{ token }}&country_id=' + this.value,
            dataType: 'json',
            success: function(json) {
                html = '<option value="">{{ text_select }}</option>';
                if (json && json != '') {
                    for (i = 0; i < json.length; i++) {
                        html += '<option value="' + json[i]['value'] + '"';
                        html += '>' + json[i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected">{{ text_none }}</option>';
                }

                $('#payment_address_zone_id_input select').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    $('body').on('change', '#shipping_address_country_id_input select', function() {
        $.ajax({
            url: 'index.php?route=extension/module/d_quickcheckout/getZone&user_token={{ token }}&country_id=' + this.value,
            dataType: 'json',
            success: function(json) {
                html = '<option value="">{{ text_select }}</option>';
                if (json && json != '') {
                    for (i = 0; i < json.length; i++) {
                        html += '<option value="' + json[i]['value'] + '"';
                        html += '>' + json[i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected">{{ text_none }}</option>';
                }

                $('#shipping_address_zone_id_input select').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    $('body').on('click', '.pagination li a', function() {
        var pag_url = $(this).attr('href');

        $.ajax({
            url: pag_url,
            type: 'get',
            data: pag_url,
            dataType: 'html',
            success: function(html) {
                var data_analytics = $(html).find("#d_analytics").html();
                $("#d_analytics").html(data_analytics);
            }
        });
        return false;

    });
    //--></script>

{{ footer }}