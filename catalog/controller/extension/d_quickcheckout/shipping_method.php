<?php

class ControllerExtensionDQuickcheckoutShippingMethod extends Controller {
    private $route = 'd_quickcheckout/shipping_method';

    public $action = array(
        'shipping_method/update',
        'shipping_address/update/after',
        'cart/update/after'
    );

    public function __construct($registry){
        parent::__construct($registry);

        $this->load->model('extension/d_quickcheckout/store');
        $this->load->model('extension/d_quickcheckout/method');

    }
    /**
    * Initialization
    */
    public function index($config){
        $this->document->addScript('catalog/view/theme/default/javascript/d_quickcheckout/step/shipping_method.js');

        $state = $this->model_extension_d_quickcheckout_store->getState();

    //set default values
        $state['session']['shipping_methods'] = $this->getShippingMethods();
        $this->model_extension_d_quickcheckout_store->setState($state);

        $state['session']['shipping_method'] = $this->getDefault();
        $state['config'] = $this->getConfig();

        $state['language']['shipping_method'] = $this->getLanguages();
        $state['action']['shipping_method'] = $this->action;
        $this->model_extension_d_quickcheckout_store->setState($state);

    }

    /**
    * update via ajax
    */
    public function update(){
        $this->model_extension_d_quickcheckout_store->loadState();
        $this->model_extension_d_quickcheckout_store->dispatch('shipping_method/update/before', $this->request->post);
        $this->model_extension_d_quickcheckout_store->dispatch('shipping_method/update', $this->request->post);

        $data = $this->model_extension_d_quickcheckout_store->getStateUpdated();

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($data));
    }


    /**
    * Receiver
    * Receiver listens to dispatch of events and accepts data array with action and state
    */
    public function receiver($data){
        $update_method = false;
        $update = false;

        //updating shipping_method value
        if($data['action'] == 'shipping_method/update'){

            if(isset($data['data']['shipping_method'])){
                if(is_string($data['data']['shipping_method'])){
                    $update['session']['shipping_method'] = $this->getShippingMethod($data['data']['shipping_method']);
                    $this->model_extension_d_quickcheckout_store->setState($update);
                }
            }
        }

        //updating shipping_methods after shipping_address change
        if($data['action'] == 'shipping_address/update/after' 
            && (
                $this->model_extension_d_quickcheckout_store->isUpdated('shipping_address_country_id')
                || $this->model_extension_d_quickcheckout_store->isUpdated('shipping_address_zone_id')
                || $this->model_extension_d_quickcheckout_store->isUpdated('shipping_address_address_id')
                || $this->model_extension_d_quickcheckout_store->isUpdated('shipping_address_postcode')
                )
            ){
            $update_method = true;
        }

        //updating shipping_methods after cart change
        if($data['action'] == 'cart/update/after'){
            $update_method = true;
        }

        if($update_method){
            $update['session']['shipping_methods'] = $this->getShippingMethods();
            $this->model_extension_d_quickcheckout_store->setState($update);

            $update['session']['shipping_method'] = $this->getShippingMethod();
            $this->model_extension_d_quickcheckout_store->setState($update);
        }

        if($update){

            $this->model_extension_d_quickcheckout_store->dispatch('shipping_method/update/after', $data);
        }
    }

    public function validate(){
        return true;
    }

    private function getConfig(){
        $this->load->config('d_quickcheckout/shipping_method');
        $config = $this->config->get('d_quickcheckout_shipping_method');

        $settings = $this->model_extension_d_quickcheckout_store->getSetting();
        $result = array();
        foreach($config['account'] as $account => $value){
            if(!empty($settings['config'][$account]['shipping_method'])){
                $result[$account]['shipping_method'] = $settings['config'][$account]['shipping_method'];
            }else{
                $result[$account]['shipping_method'] = array_replace_recursive($config, $value);
            }
        }

        return $result;
    }

    private function getLanguages(){
        $this->load->language('checkout/checkout');
        $this->load->language('extension/d_quickcheckout/shipping_method');

        $result = array();
        $languages = $this->config->get('d_quickcheckout_shipping_method_language');

        foreach ($languages as $key => $language) {
            $result[$key] = $this->language->get($language);
        }

        $language = $this->model_extension_d_quickcheckout_store->getLanguage();
        if(isset($language['shipping_method'])){
            $result = array_replace_recursive($result, $language['shipping_method']);
        }

        $result['image'] = HTTPS_SERVER.'image/catalog/d_quickcheckout/step/shipping_method.svg';

        return $result;
    }

    private function getDefault(){
        return $this->model_extension_d_quickcheckout_method->getDefaultShippingMethod('flat.flat');
    }

    private function getShippingMethod($shipping_method = false){
        if(!$shipping_method){
            $state = $this->model_extension_d_quickcheckout_store->getState();
            $shipping_method = $state['session']['shipping_method']['code'];
        }
        return $this->model_extension_d_quickcheckout_method->getDefaultShippingMethod($shipping_method);
    }

    private function getShippingMethods(){
        $state = $this->model_extension_d_quickcheckout_store->getState();
        $new_shipping_methods = $this->model_extension_d_quickcheckout_method->getShippingMethods($state['session']['shipping_address']);

        if(isset($state['session']['shipping_methods'])){
            foreach($state['session']['shipping_methods'] as $key => $value){
                if(!isset($new_shipping_methods[$key])){
                    $new_shipping_methods[$key] = false;
                }
            }
        }
        

        return $new_shipping_methods;
    }


}
