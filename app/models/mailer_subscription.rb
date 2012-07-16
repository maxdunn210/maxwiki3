class MailerSubscription < MaxWikiActiveRecord

  belongs_to :wiki; default_scope method :wiki_filter
  belongs_to :mailer
  belongs_to :user
end
