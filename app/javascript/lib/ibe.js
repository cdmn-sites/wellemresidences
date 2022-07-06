import iFrameResize from "iframe-resizer"

const ibe = {

  /**
  * Default Settings
  * Overriden by data attributes on the body tag or the element tag.
  */
  
    settings: {
      version:              0.97,
      container:            'ibe',
      debug:                false,
      region:               'apac',
      region_subdomain:     {emea: 'app', apac: 'app-apac'},
      domain:               'thebookingbutton.com',
      property_customdomain: false,
      templates: {
        property:                 'https://{region_subdomain}.{domain}/{clientid}properties/{channelcode}',
        property_customdomain:    'https://{property_customdomain}/{clientid}properties/{channelcode}',
        widgets: {
          ga_proxy:                     'https://{region_subdomain}.{domain}/{clientid}/ga_proxy',
          ga_proxy_customdomain:        'https://{property_customdomain}/{clientid}/ga_proxy',
          property_check_availability:              'https://{region_subdomain}.{domain}/properties/{channelcode}/booking_widget',
          property_check_availability_customdomain: 'https://{property_customdomain}/properties/{channelcode}/booking_widget',
          property_grid:                            'https://{region_subdomain}.{domain}/properties/{channelcode}/widget',
          property_grid_customdomain:               'https://{property_customdomain}/properties/{channelcode}/widget'
        }
      },
      ga_active:            ( typeof window[window['GoogleAnalyticsObject']] !== 'undefined' ) === true,
      ga_classname:         'ibe_decorate',
      query:                [],
      postmessage_domains:  [],
      allowed_query_vars:   ['check_in_date','check_out_date','number_nights','number_adults','number_children','number_infants','promo_code','campaign','locale','currency','room_type','room_rate','rate_plan'],
      mobile_fullscreen:    'true'
    },
  
    /** Returns the global GoogleAnalyticsObject
     *  - we use this instead of `ga` since that variable can be renamed
     */
    googleAnalyticsObject: window[window['GoogleAnalyticsObject']],
  
    /** Returns Elements by ClassName
    *  - cross-browser-compatible function to retrieve all elements with a given classname
    *  - relies on native 'getElementsByClassName' if supported or falls back to run through all elements
    */
    getElements: function(className) {
      if (document.getElementsByClassName) {
        return document.getElementsByClassName(className);
      }
  
      /* Fallback for older browser versions */
      var containers = [];
      var elements = document.getElementsByTagName('*');
  
      for (var i in elements) {
        if (elements[i].className && elements[i].className.indexOf(className) !== -1) {
          var c = elements[i].className.split(' ');
          for (var l in c) {
            if (c[l] == className) {
              containers.push(elements[i]);
              break;
            }
          }
        }
      }
      return containers;
    },
  
    /**
     * Parse Data-Attributes of an element
     * - return data attributes of an element as an assoc array,
     *   stripping 'data-' from the attribute name.
     */
    getDataAttributes: function(p) {
      var s = {query: []};
      var a = p.attributes;
      var m = a.length;
  
      for (var i = 0; i < m; i++) {
        if (a.item(i).nodeType === 2
            && a.item(i).name.indexOf('data-') === 0
            && a.item(i).value.length) {
          if (a.item(i).name.indexOf('data-query-') === 0) {
            s.query.push(a.item(i).name.substr(11).toLowerCase() + '=' + escape(a.item(i).value));
          } else {
            s[a.item(i).name.substr(5).toLowerCase()] = a.item(i).value;
          }
        }
      }
      return s;
    },
  
    /* Retrieve recognised query parameters
    */
    getUrlParameters: function(query_params)
    {
      var query_string = (document.location.href.split('?'))[1];
      if (query_string && query_string.length)
      {
          var query_vars = query_string.split('&');
          for( var i in query_vars)
          {
              var query_var = query_vars[i].split('=');
              if (this.settings.allowed_query_vars.indexOf(query_var[0]) >= 0 && query_var[1].length)
              {
                  query_params.push( query_vars[i] );
              }
          }
      }
      return query_params;
    },
  
    /** Simple Array Extension
    * - array B overrides values in array A
    *   and extends it by any key/value pairs contained in B
    * @todo Is there a more elegant way?
    */
    extend: function(a, b) {
      var c = {};
      for (var i in a) {
        c[i] = a[i];
      }
      for (var i in b) {
        c[i] = b[i];
      }
      return c;
    },
  
    /*
     * Retrieve GA linkerParam from passed Tracker or from the first GA Instance found
     */
    getLinker: function(tracker) {
      var linker;
      if (tracker) {
        linker = tracker.get('linkerParam');
      } else {
        linker = ga.getAll()[0].get('linkerParam');
      }
      return linker;
    },
  
    /**
     * Decorate Links and Forms with Cross-Domain Tracking
     *  - Works on all elements that contain class name used to
     *    identify links requiring source attribution.
     *  - Appends a hidden input field or a query parameter containing Google client ID
     *  - Triggered from GA directly
     */
    decorate: function(tracker) {
      var linker = ibe.getLinker(tracker);
      /* Get all elements needing cross-domain tracking */
      var ga_elements = ibe.getElements(ibe.settings.ga_classname);
      for (var i in ga_elements) {
        var ga_element = ga_elements[i];
        if (ga_element.getAttribute && ga_element.getAttribute('data-dst')) {
          if (ga_element.tagName === 'IFRAME') {
  
            ga_element.setAttribute('src', ibe.getDecoratedURL(ga_element, linker));
          } else if (ga_element.tagName === 'FORM') {
            /* Set Form action and append GA input field */
            ga_element.action = ga_element.getAttribute('data-dst');
            var linker_params = linker.split('&');
            for (var i in linker_params)
            {
                var linker_value = linker_params[i].split('=');
                var inp = document.createElement('input');
                inp.setAttribute('name',  linker_value[0]);
                inp.setAttribute('value', linker_value[1]);
                inp.setAttribute('type',  'hidden');
                inp.name  = linker_value[0];
                inp.value = linker_value[1];
                inp.type  = 'hidden';
                ga_element.appendChild(inp);
            }
          } else {
            /* Set Hyperlink Destination */
            ga_element.setAttribute('href', ibe.getDecoratedURL(ga_element, linker));
          }
          ga_element.removeAttribute('data-dst');
        }
      }
    },
    /**
    * Return either a question mark or and ampersand for adding query params to an URL
    */
    getQuerySeparatorForUrl: function (url) {
      return url.indexOf('?') > 0 ? '&' : '?';
    },
  
    /**
    * Return GA-decorated URL for an element
    */
    getDecoratedURL: function(ga_element, linker) {
      var dst = ga_element.getAttribute('data-dst');
      return dst + ibe.getQuerySeparatorForUrl(dst) + linker;
    },
  
    /** Return TBB URL for a Property
    *  To build the correct URL takes :
    - channel code,
    - clientID (if applicable),
    - region,
    - domain
    */
    getPropertyUrl: function(s, widgetTemplate) {
      var url;
      if (!s.channelcode) {
        ibe.debug('IBE: No Property Channelcode found!');
        url = '#error-no-channelcode-found';
      }
  
      if (widgetTemplate !== false && ibe.settings.templates.widgets[widgetTemplate])
      {
        if (s.property_customdomain !== false) {
          url = ibe.settings.templates.widgets[widgetTemplate +'_customdomain']
            .replace('{property_customdomain}',  s.property_customdomain)
        } else {
          url = ibe.settings.templates.widgets[widgetTemplate]
                .replace('{region_subdomain}',     s.region_subdomain[s.region])
                .replace('{domain}',               s.domain);
        }
      } else {
  
        if (s.property_customdomain !== false) {
          url = ibe.settings.templates.property_customdomain
            .replace('{property_customdomain}',  s.property_customdomain)
        } else {
          url = ibe.settings.templates.property
            .replace('{region_subdomain}',     s.region_subdomain[s.region])
            .replace('{domain}',               s.domain)
        }
      }
      url = url.replace('{channelcode}',   escape(s.channelcode))
              .replace('{clientid}',      ibe.formatClientId(s));
  
      return url + (s.query.length > 0 ? '?' + s.query.join('&') : '');
    },
  
  
    /**
    * Format ClientID
    */
    formatClientId: function(s) {
      return (s.clientid ? escape(s.clientid) + '/' : '');
    },
  
    /**
    * Display debug information for Google Analytics
    */
    decorate_debug: function(tracker) {
      var ua = tracker ? tracker.get('trackingId') : ga.getAll()[0].get('trackingId');
      var el = ibe.getElements(ibe.settings.ga_classname);
      ibe.debug('IBE: Decorating '+ el.length + ' Links, Forms or Frames with cross-domain tracking for Google Analytics Client ID "' + ua + '"');
    },
  
    /**
    * Display debug information if enabled.
    */
    debug: function(message) {
      if (ibe.settings.debug) {
        console.log( message );
      }
    },
  
    backwardCompatibleWidgetGA: function(s)
    {
      if (this.settings.ga_active && !document.getElementById( 'ga_proxy_'+ s.channelcode))
      {
        if (s.clientid)
        {
          ibe.debug('IBE: Creating Proxy Frame for cross-domain tracking for clientID "'+ s.clientid +'"');
          var f = document.createElement('iframe');
          f.style.display   = 'none';
          f.style.width    = '1px';
          f.style.height   = '1px';
          f.style.overflow = 'hidden';
          f.setAttribute('data-dst', this.getPropertyUrl(this.extend(this.settings, s), 'ga_proxy'));
          f.className += ' ' + this.settings.ga_classname;
          f.id = 'ga_proxy_'+ s.channelcode;
          document.body.appendChild(f);
        } else {
          ibe.debug('IBE: Cross-domain Tracking requires a clientID to be set up')
        }
      }
    },
  
    /** Initiate Linking and Cross-domain Tracking
    *  - builds link and form destinations for all elements marked with the trigger classname
    *  - initiates cross-domain tracking mechanism to decorate links once GA is loaded
    */
    go: function() {
      this.settings = this.extend(this.settings, this.getDataAttributes(document.body));
  
      this.debug('IBE: Initiating IBE.JS Version ' + this.settings.version);
  
      var elements  = this.getElements(this.settings.container);
      var m = elements.length;
  
      this.debug('IBE: Found ' + m + ' Elements with class name "' + this.settings.container + '":', elements);
      var isDesktop = false;
      for (var i = 0; i < m; i++) {
        /* Widgets! */
        if (elements[i].tagName === 'DIV') {
          var s = this.getDataAttributes(elements[i]);
          s.query = this.getUrlParameters(s.query);
  
          var widgetSettings = this.extend(this.settings, s)
  
          this.debug(`IBE Widget Settings: \n ${JSON.stringify(widgetSettings, null, 2)}`)
  
          if (s.widget.toLowerCase() == 'property_check_availability') {
            this.debug('IBE: Creating Property check availability widget');
            var f = document.createElement('iframe');
            f.style.border   = 'none';
            f.style.width    = '250px';
            f.style.height   = '200px';
            f.style.overflow = 'hidden';
            f.setAttribute('src', this.getPropertyUrl(this.extend(this.settings, s), 'property_check_availability'));
            elements[i].appendChild(f);
            this.backwardCompatibleWidgetGA( this.extend(this.settings, s) );
  
          } else if (s.widget.toLowerCase() == 'property_grid') {
            this.debug('IBE: Creating Property Availability Grid widget');
            var f = document.createElement('iframe');
            f.style.border   = 'none';
            f.style.width    = '100%';
            f.style.minWidth = '800px';
            f.style.height   = (s.height || 500) + 'px';
            f.style.overflowX = 'hidden';
            f.setAttribute('src', this.getPropertyUrl(this.extend(this.settings, s), 'property_grid'));
            elements[i].appendChild(f);
            this.backwardCompatibleWidgetGA( this.extend(this.settings, s) );
  
          } else if (s.widget.toLowerCase() == 'embed') {
            var f = document.createElement('iframe');
            f.className      = this.settings.container;
            f.style.border   = 'none';
            f.style.width    = '100%';
  
            if (screen.width < 768) {
              this.debug('IBE: Creating embedded widget: Mobile Version');
  
              /* Add Viewport Meta Tag */
              var metaTag=document.createElement('meta');
              metaTag.name                  = 'viewport';
              metaTag.content               = 'initial-scale=1, maximum-scale=1, minimum-scale=1';
              document.getElementsByTagName('head')[0].appendChild(metaTag);
  
              f.style.width                 = '100%';
              f.style.height                = '100%';
              f.style.position              = 'static';
  
              if (widgetSettings.mobile_fullscreen === 'true') {
                this.debug('IBE: Mobile Version - in fullscreen mode');
                f.style.position              = 'absolute';
                f.style.top                   = 0;
                document.body.style.overflow  = 'hidden';
              }
  
              document.body.style.padding   = 0;
              document.body.style.margin    = 0;
              document.body.style.position  = 'unset';
            } else {
              var isTablet = screen.width < 1024
              this.debug(`IBE: Creating embedded widget: ${isTablet ? 'Tablet': 'Desktop'} Version`);
  
              s.query.push('skin=0');
              f.setAttribute('scrolling', 'no');
              f.style.overflow            = 'hidden';
              f.style.height              = '900px';
              f.style.minWidth            = '768px';
              f.style.maxWidth            = '1024px';
              f.style.borderRadius        = '3px';
              if (window.postMessage) {
                f.style.height              = '200px';
                f.style.overflow            = 'hidden';
                f.className                += ' '+ this.settings.container +'fr';
              }
  
              // this will set the flag that will
              // turn on the auto-resize after the frame dom has been attached.
              isDesktop = true
            }
  
            /* Set source */
            f.setAttribute(
              this.settings.ga_active ? 'data-dst' : 'src',
              this.getPropertyUrl(this.extend(this.settings, s), false)
            );
  
            /* Flag for cross-domain tracking */
            if (this.settings.ga_active) {
              f.className += ' '+ this.settings.ga_classname;
            }
  
            /* Append frame to DIV */
            if (screen.width < 768 && widgetSettings.mobile_fullscreen === 'true') {
              this.debug('IBE: Creating embedded widget: Mobile Version - in fullscreen mode - hiding all other body elements');
              var x = document.body.childNodes;
              var m = x.length;
              for (var i=0; i<m; i++)
              {
                if (x[i].nodeType == 1 && x[i].tagName !== 'SCRIPT')
                {
                  x[i].style.display ='none';
                }
              }
              document.body.appendChild(f);
            } else {
              elements[i].appendChild(f);
            }
            if (isDesktop && window.postMessage) {
              iFrameResize.iframeResizer({log: false, checkOrigin: false}, '.' + this.settings.container + 'fr')
            }
  
            // Scroll up
            if (widgetSettings.mobile_fullscreen === 'false') {
              f.onload = () => {
                setTimeout(() => {
                  this.debug('..scrolling up..')
                  document.body.scrollTo(0, 0);
                  this.debug('..done scrolling up..')
                }, 1000)
              }
            }
            break;
          }
  
          /* Links and forms */
        } else {
          elements[i].setAttribute(
            this.settings.ga_active ? 'data-dst' : (elements[i].tagName === 'FORM' ? 'action' : 'href'),
            this.getPropertyUrl(this.extend(this.settings, this.getDataAttributes(elements[i])), false)
          );
  
          if (this.settings.ga_active) {
            elements[i].className += ' ' + this.settings.ga_classname;
          }
        }
  
      }
  
      if (!this.settings.ga_active && typeof dataLayer !== 'undefined') {
        // possible Google Analytics via GTM, customer may not have configured GA in GTM
        // dataLayer may be unreliable since the variable name can change
        // logging right away to easily check the problem (e.g. customer has GTM but it's not tracking)
        console.warn('IBE: dataLayer found but Google Analytics seems to be missing: Ensure Analytics is placed before ibe.js');
      }
  
      /* Google Analytics Cross-Domain Tracking */
      if (this.settings.ga_active) {
       /* Google Analytics (direct) */
       this.googleAnalyticsObject(ibe.decorate);
       if (this.settings.debug) {
         console.log('IBE: Google Analytics found');
         this.googleAnalyticsObject(ibe.decorate_debug);
       }
      } else {
        this.debug('IBE: No Google Analytics found: Ensure Analytics is placed before ibe.js');
      }
      return this;
    }
  };

export default ibe