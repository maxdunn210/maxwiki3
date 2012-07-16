require 'test_helper'

class EmailTest < ActiveSupport::TestCase
  fixtures :emails, :wikis

  def test_new
    email = Email.new
    assert_equal 1, email.wiki_id, "Wrong wiki_id"
  end
end
