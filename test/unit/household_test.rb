require 'test_helper'

class HouseholdTest < ActiveSupport::TestCase
  fixtures :households, :wikis

  def test_new
    household = Household.new
    assert_equal 1, household.wiki_id, "Wrong wiki_id"
  end
end
