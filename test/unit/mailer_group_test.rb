require 'test_helper'

class MailerGroupTest < ActiveSupport::TestCase
  fixtures :mailer_groups, :wikis

  def test_new
    mailer_group = MailerGroup.new
    assert_equal 1, mailer_group.wiki_id, "Wrong wiki_id"
  end  

end
