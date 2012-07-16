# Plugin authorization providers. Contains the authorization provider class
AUTH_PROVIDERS = []

# Items that need to store configuration information
WIKI_CONFIG_ITEMS = [
  {:title => 'Main', :template => 'main'},
  {:title => 'Signup', :template => 'signup'},
]

# Control whether deprecation warnings are displayed
ActiveSupport::Deprecation.silenced = false #MD DEBUG Nov 6, 2008

# Localization
=begin # MD DEBUG Jul-2012
module Localization
  CONFIG = {
    # Default language
    :default_language => 'en',
    :web_charset => 'utf-8'
  }
  
  if CONFIG[:web_charset] == 'utf-8'
    $KCODE = 'u'
    require 'jcode'
  end
end
=end

# Instiki-specific configuration below
require_dependency 'instiki_errors'

# Flickr configuration
MY_CONFIG[:flickr_cache_file] = "#{Rails.root.to_s}/config/flickr.cache"
MY_CONFIG[:rflickr_lib] = true

# Special pages  
MY_CONFIG[:layout_sections] = ['header', 'menu', 'footer']
MY_CONFIG[:welcome_page] = 'Welcome'

# Roles
ROLE_PUBLIC = 'Public'
ROLE_USER = 'User'
ROLE_EDITOR = 'Editor'
ROLE_ADMIN = 'Admin'
MY_CONFIG[:roles] = {ROLE_PUBLIC => [], 
  ROLE_USER => [ROLE_PUBLIC],
  ROLE_EDITOR => [ROLE_USER],
  ROLE_ADMIN => [ROLE_EDITOR]}
MY_CONFIG[:default_role] = ROLE_USER

# Email Status
EMAIL_QUEUED = 'Queued'
EMAIL_SENT = 'Sent'
EMAIL_ERROR = 'Error'
EMAIL_FATAL_ERROR = 'Fatal Error'

# String to use in Regular Expressions to detect emails
EMAIL_VALID_RE_STR = '[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'

# Define Okaapi content type (uncomment if okaapi_plugin not present...)
Okaapi.content  = :maxwiki if defined? Okaapi

# Upload file configuration
# :file_upload_root is the where the web server will start looking. No need to ever change this
# :file_upload_top is the topmost directory that file attachments should go in. This is separated out for security checks
# :file_upload_directory is the variable part and can include '%w' for wiki name and '%p' for page name
MY_CONFIG[:file_upload_root] = File.expand_path(File.join(Rails.root.to_s, 'public'))
MY_CONFIG[:file_upload_top] = '/files/attachments'
MY_CONFIG[:file_upload_directory] = '/%w/%p'

# Number of blog posts per page
MY_CONFIG[:blog_posts_per_page] = 10





