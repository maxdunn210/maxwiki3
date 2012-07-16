class Email < MaxWikiActiveRecord

  belongs_to :wiki; default_scope method :wiki_filter
  belongs_to :user
  belongs_to :mailer
end
