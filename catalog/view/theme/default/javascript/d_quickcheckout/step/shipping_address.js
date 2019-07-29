/**
 *   ShippingAddress Model
 */

(function() {

    this.subscribe('shipping_address/update', function(data) {
        clearTimeout(this.payment_address_timer);

        this.setState({ 'session': data });
        var difference = this.getChange();

        this.payment_address_timer = setTimeout(function() {
            this.send('extension/d_quickcheckout/shipping_address/update', difference, function(json) {
                this.setState(json);
                //in further need add payment and shipping methods content(architecture) due deep-merge can't properly merge with empty content
                if(getSession().payment_address.shipping_address){
                    this.updateState(['session', 'shipping_methods'],json.session.shipping_methods);
                }
                //
                this.setChange(this.getState());
            }.bind(this));
        }, 10);

    });

    //show/hide shipping address immediately
    this.subscribe('payment_address/update', function(data) {
        var state = this.getState();
        if (data.payment_address.shipping_address && state.session.has_shipping) {
            if (data.payment_address.shipping_address == 1) {
                this.updateState(['config', this.getAccount(), 'shipping_address', 'display'], 0);
            } else {
                this.updateState(['config', this.getAccount(), 'shipping_address', 'display'], 1);
            }
        } else if (!state.session.has_shipping) {
            this.updateState(['config', this.getAccount(), 'shipping_address', 'display'], 0);
        }
    });

    this.subscribe('shipping_address/edit', function(data) {
        this.setState(data);
    });

})(qc);