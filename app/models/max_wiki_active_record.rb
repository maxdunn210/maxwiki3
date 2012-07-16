class MaxWikiActiveRecord < ActiveRecord::Base
  
  # include MaxWiki::MaxWikiActiveRecordInclude if defined? MaxWiki::MaxWikiActiveRecordInclude
  
  self.abstract_class = true
  cattr_accessor :current_wiki, :current_page_link, :system_read_only_mode, :system_read_only_msg
  
  
  def initialize(*args)
    super
    readonly! if @@system_read_only_mode
    self.wiki_id = @@current_wiki.id if @@current_wiki && respond_to?('wiki_id')
  end 
  
  def self.count(*args)
    with_scope(wiki_filter) do
      super
    end  
  end 
  
  def self.delete_all(*args)
    raise ReadOnlyRecord if @@system_read_only_mode
     with_scope(wiki_filter) do
        super
      end
  end
  
  def self.update_all(*args)
    raise ReadOnlyRecord if @@system_read_only_mode
    super
  end
  
  def self.system_read_only_msg
    @@system_read_only_msg || 'System is in read-only maintenance mode.'
  end
  
  def self.find_foo(*arguments)
    with_scope(wiki_filter) do
      super
    end
  end
    
  #---------------------
  #private
  
  def self.wiki_filter
    if current_wiki.nil?
      return nil
    elsif self.class == Class 
      return nil unless column_names.include?('wiki_id')
    else  
      return nil unless respond_to?('wiki_id')
    end 
    
    #TODO It doesn't filter the "wikis" table. Might want to do this for security.
    where("#{self.table_name}.wiki_id = #{current_wiki.id}")
  end
  
  def self.find_every(options)
    if @@system_read_only_mode
      options = {} if options.nil?
      options[:readonly] = true
    end
    with_scope(wiki_filter) do
      super(options)
    end  
  end
  
end