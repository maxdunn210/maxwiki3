require 'test_helper'

class AdultTest < ActiveSupport::TestCase
  fixtures :adults, :wikis
  
  def test_new
    adult = Adult.new
    assert_equal 1, adult.wiki_id, "Wrong wiki_id"
  end
  
  def test_count
    if Rails::Plugin::ACTIVE_PLUGINS.include?('maxwiki_multihost')
      num = 11
    else
      num = 12
    end
    assert_equal(num, Adult.count)
  end
end
