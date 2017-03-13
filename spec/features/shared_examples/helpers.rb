require "cgi"
include ActionView::Helpers::SanitizeHelper

def html_unescape(text)
  CGI.unescapeHTML(strip_tags(text))
end

def sign_in_as(user, path: "/")
  login_as(user, scope: :user)
  visit(path)
end
