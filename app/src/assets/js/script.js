;(function ( $, window, document, undefined ) {
    var pluginName = "cookieDialog",
        defaults = {
            propertyName: "value"
        };

    // The actual plugin constructor
    function Plugin( element, options ) {
        this.element = element;
    	this.$element = $(this.element);

        this.options = $.extend( {}, defaults, options) ;

        this._defaults = defaults;
        this._name = pluginName;

        this.init();
    }

    Plugin.prototype = {

        init: function() {
        	var self = this;

        	if(!self.getCookie(self)){
        		self.$element.addClass('visible');
        	}

            self.$element.on('click', '#cookie-dialog-close', function(e) {
            	self.close(e, self);
            });
        },

        close: function(e, self) {
        	e.preventDefault();
            self.$element.removeClass('visible');
            self.setCookie(self);
        },

        setCookie: function(self) {
        	$.cookie(self.options.cookieName, true, { expires: self.options.expires, path: '/' });
        },

        getCookie: function(self) {
        	return $.cookie(self.options.cookieName);
        }
    };

    // A really lightweight plugin wrapper around the constructor,
    // preventing against multiple instantiations
    $.fn[pluginName] = function ( options ) {
        return this.each(function () {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName,
                new Plugin( this, options ));
            }
        });
    };

})( jQuery, window, document );

$('#cookieDialog').cookieDialog({
	cookieName: 'cookieConsent',
	expires: 7
});