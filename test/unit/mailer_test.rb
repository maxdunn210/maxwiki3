require 'test_helper'

class MailerTest < ActiveSupport::TestCase
  fixtures :mailers, :wikis

  def setup
    setup_wiki
  end
  
  def test_new
    mailer = Mailer.new
    assert_equal 1, mailer.wiki_id, "Wrong wiki_id"
  end  

end
