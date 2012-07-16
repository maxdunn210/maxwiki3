require 'test_helper'

class MailerSubscriptionTest < ActiveSupport::TestCase
  fixtures :mailer_subscriptions, :wikis

  def setup
    setup_wiki
  end
  
  def test_new
    mailer_subscription = MailerSubscription.new
    assert_equal 1, mailer_subscription.wiki_id, "Wrong wiki_id"
  end  

end
