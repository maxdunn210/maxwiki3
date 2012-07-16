class Mailer < MaxWikiActiveRecord

  belongs_to :wiki; default_scope method :wiki_filter
  belongs_to :mailer_group
  has_many :emails
end
