class MailerGroup < MaxWikiActiveRecord

  belongs_to :wiki; default_scope method :wiki_filter
  has_one :mailer
end
