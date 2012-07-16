# Fix expire_page so that it can recursively delete many pages based on a regular expression  
# Most of this code is taken from FileStore and expire_fragment
module ActionController::Caching::Pages
  
  module ClassMethods
    
    def delete(path) #:nodoc:
      File.delete(page_cache_path(path))
    rescue SystemCallError => e
      # If there's no cache, then there's nothing to complain about
    end
    
    def delete_matched(matcher) #:nodoc:
      search_dir(page_cache_directory) do |f|
        if f =~ matcher
          begin
            File.delete(f)
          rescue SystemCallError => e
            # If there's no cache, then there's nothing to complain about
          end
        end
      end
    end
    
    def search_dir(dir, &callback)
      Dir.foreach(dir) do |d|
        next if d == "." || d == ".."
        name = File.join(dir, d)
        if File.directory?(name)
          search_dir(name, &callback)
        else
          callback.call name
        end
      end
    end
    
    def expire_page(path)
      return unless perform_caching
      
      if path.is_a?(Regexp)
        delete_matched(path)
      else
        delete(path)
      end
    end
  end  
  
  # Expires the page that was cached with the +options+ as a key. Example:
  #   expire_page :controller => "lists", :action => "show"
  #MD Also accepts regular expressions and then does a recursive delete of those files
  def expire_page(options = {})
    return unless perform_caching
    if options.is_a?(Regexp)
      self.class.expire_page(options)
    elsif options[:action].is_a?(Array)
      options[:action].dup.each do |action|
        self.class.expire_page(url_for(options.merge({ :only_path => true, :skip_relative_url_root => true, :action => action })))
      end
    else
      self.class.expire_page(url_for(options.merge({ :only_path => true, :skip_relative_url_root => true })))
    end
  end
end

#Don't escape + in URLS
#module ActionView::Helpers::UrlHelper
#  alias mw_original_url_for url_for
#  def url_for(options = {})
#    mw_original_url_for(options).gsub('%2B','+')
#  end
#end

class File
  def File.suffix(name)
    suffix_size = File.basename(name).size - File.basename(name,'.*').size - 1
    if suffix_size <= 0
      return ''
    else
      return name.last(suffix_size)
    end  
  end
end

class Dir
  class << self
    alias mw_orig_entries entries
    
    def entries(path, *options)
      names = mw_orig_entries(path)
      if options.blank?
        return names
      end  
      
      list = []
      any_file = (options & [:files, :directories]).blank?
      names.each do |name|
        next if name[0,1] == "." if options.include?(:nodots)
        
        is_dir = File.directory?(File.join(path, name))
        if any_file ||
         (is_dir && options.include?(:directories)) ||
         (!is_dir && options.include?(:files))
          list << name
        end
      end
      list
    end
  end
end

module URI
  module Escape
    
    # Check first to see if there are already escaped characters so we don't escape them twice 
    alias maxwiki_old_escape escape
    def escape(str, unsafe = UNSAFE)
      if str =~ URI::REGEXP::ESCAPED
        str
      else
        maxwiki_old_escape(str, unsafe)
      end
    end
  end
end    

# PostgreSQL doesn't have the current_database method, so add it here
module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter
      
      alias maxwiki_old_initialize initialize
      def initialize(connection, logger, params, config = {})
        @database = config[:database]
        maxwiki_old_initialize(connection, logger, params, config)
      end
      
      def current_database
        @database
      end
      
    end
  end
end

# Allow comma delimited lists in email addresses
=begin # MD DEBUG Jul-2012
module ActionMailer
  class Base
    
    alias :create_mail_maxwiki_old :create_mail
    
    def create_mail
      if @recipients.class == String
        @recipients = @recipients.scan(/\b#{EMAIL_VALID_RE_STR}\b/mi)
      end
      create_mail_maxwiki_old
    end
  end  
end
=end

# Fix follow_redirect to be able to use a string
module Test
  module Unit
    class TestCase #:nodoc:
      
      def follow_redirect
        if (@response.redirected_to.is_a? String)
          action_hash = ActionController::Routing::Routes.recognize_path(@response.redirected_to.gsub(/^\w+:\/\/.*?\//,"/"))
        else
          action_hash = @response.redirected_to
        end
        redirected_controller = action_hash[:controller]
        
        if redirected_controller && redirected_controller != @controller.controller_name
          raise "Can't follow redirects outside of current controller (from #{@controller.controller_name} to #{redirected_controller})"
        end
        get(action_hash.delete(:action), action_hash.stringify_keys)
      end  
    end
  end
end

module ActionView
  module Helpers
    class DateTimeSelector
      def select_hour_with_twelve_hour_time 
        return select_hour_without_twelve_hour_time unless @options[:twelve_hour].eql? true
        if @options[:use_hidden] || @options[:discard_hour]
          build_hidden(:hour, hour)
        else
          select_options = []
          0.step(23, 1) do |value|
            if value == 0 
              if @options[:midnight]
                text = @options[:midnight].eql?(true) ? 'midnight' : @options[:midnight]
              else
                text = '12am'
              end
            elsif value == 12 && @options[:noon]
              text = @options[:noon].eql?(true) ? 'noon' : @options[:noon]
            else
              text = "#{value == 12 ? 12 : (value / 12 == 1 ? value % 12 : value)}#{value <= 11 ? 'am' : 'pm'}"
            end
            tag_options = { :value => value }
            tag_options[:selected] = "selected" if hour == value
            select_options << content_tag(:option, text, tag_options)
          end
          select_options.unshift(@options[:prompt]) if @options[:prompt].present?
          build_select(:hour, (select_options.join("\n") + "\n").html_safe)
        end       
      end           
      alias_method_chain :select_hour, :twelve_hour_time     
    end   
  end
end
