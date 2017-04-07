###!
# jQuery Cookie Plugin v1.4.1
# https://github.com/carhartl/jquery-cookie
#
# Copyright 2006, 2014 Klaus Hartl
# Released under the MIT license
###

((factory) ->
  if typeof define == 'function' and define.amd
    # AMD (Register as an anonymous module)
    define [ 'jquery' ], factory
  else if typeof exports == 'object'
    # Node/CommonJS
    module.exports = factory(require('jquery'))
  else
    # Browser globals
    factory jQuery
  return
) ($) ->
  pluses = /\+/g
  config =
  $.cookie = (key, value, options) ->
    # Write
    if arguments.length > 1 and !$.isFunction(value)
      options = $.extend({}, config.defaults, options)
      if typeof options.expires == 'number'
        days = options.expires
        t = options.expires = new Date
        t.setMilliseconds t.getMilliseconds() + days * 864e+5
      return document.cookie = [
        encode(key)
        '='
        stringifyCookieValue(value)
        if options.expires then '; expires=' + options.expires.toUTCString() else ''
        if options.path then '; path=' + options.path else ''
        if options.domain then '; domain=' + options.domain else ''
        if options.secure then '; secure' else ''
      ].join('')
    # Read
    result = if key then undefined else {}
    cookies = if document.cookie then document.cookie.split('; ') else []
    i = 0
    l = cookies.length
    while i < l
      parts = cookies[i].split('=')
      name = decode(parts.shift())
      cookie = parts.join('=')
      if key == name
        # If second argument (value) is a function it's a converter...
        result = read(cookie, value)
        break
      # Prevent storing a cookie that we couldn't decode.
      if !key and (cookie = read(cookie)) != undefined
        result[name] = cookie
      i++
    result

  encode = (s) ->
    if config.raw then s else encodeURIComponent(s)

  decode = (s) ->
    if config.raw then s else decodeURIComponent(s)

  stringifyCookieValue = (value) ->
    encode if config.json then JSON.stringify(value) else String(value)

  parseCookieValue = (s) ->
    if s.indexOf('"') == 0
      # This is a quoted cookie as according to RFC2068, unescape...
      s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\')
    try
      # Replace server-side written pluses with spaces.
      # If we can't decode the cookie, ignore it, it's unusable.
      # If we can't parse the cookie, ignore it, it's unusable.
      s = decodeURIComponent(s.replace(pluses, ' '))
      return if config.json then JSON.parse(s) else s
    catch e
    return

  read = (s, converter) ->
    value = if config.raw then s else parseCookieValue(s)
    if $.isFunction(converter) then converter(value) else value

  config.defaults = {}

  $.removeCookie = (key, options) ->
    # Must not alter options, thus extending a fresh object...
    $.cookie key, '', $.extend({}, options, expires: -1)
    !$.cookie(key)

  return
