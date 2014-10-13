#lua-resty-qless-web

### Overview
Port of Moz's [qless](https://github.com/seomoz/qless) web interface to the [Openresty](http://www.openresty.org) environment.


### Dependencies
 * [lua-resty-qless](https://github.com/pintsized/lua-resty-qless)
 * [lua-resty-template](https://github.com/bungle/lua-resty-template)

### Methods

#### new
`syntax: ok, err = Qless_web:new(opts)`

`opts` is a table of options
 * `client` must be an instance of [lua-resty-qless](https://github.com/pintsized/lua-resty-qless)
 * `uri_prefix` defaults to `/`, sets the value prepended to all URIs


#### run

`syntax: ok, err = qless_web:run()`

Performs routing based on current uri.
Requires a sub-location `/__static` configure to serve static assets

### Config

```
init_by_lua '
    -- Require here to compile templates
    local Qless_Web = require("resty.qless-web")
';

location /web {

    default_type text/html;
    location /web/__static {
        internal;
        rewrite ^/web/__static(.*) $1 break;
        root /path/to/lua-resty-qless-web/static/;
    }

    content_by_lua '
        -- Connect Qless client
        local resty_qless = require "resty.qless"
        local qless, err = resty_qless.new(
            {
                redis = { host = "127.0.0.1", port = 6379 }
            },
            { database = 1 }
        )
        if not qless then
            return ngx.say("Qless.new(): ", err)
        end

        -- Create and run qless web
        local Qless_Web = require("resty.qless-web")
        local web = Qless_Web:new({ client = qless, uri_prefix = "/web" })

        web:run()
    ';
}
