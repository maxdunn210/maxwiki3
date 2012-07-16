require 'test_helper'

class JoinAssociationTest < ActiveSupport::TestCase
  fixtures :wikis, :adults, :households, :players, :teams, :lookups
  
  def test_include1
    users = Adult.find(:all, 
    :conditions => "households.zip = '95129'", 
    :include => :household)
    if Rails::Plugin::ACTIVE_PLUGINS.include?('maxwiki_multihost')
      num = 6
    else
      num = 7
    end
    assert_equal(num, users.size)
  end
  
  def test_include2
    users = Adult.find(:all, 
    :conditions => ["players.info_checked = ?", true], 
    :include => {:household => :players})
    assert_equal(5, users.size)
  end
  
  def test_include3
    users = Adult.find(:all, 
    :conditions => "teams.name = 'As'", 
    :include => {:household => {:players => :team}})
    assert_equal(4, users.size)
  end
  
  def test_include4
    users = Adult.find(:all, 
    :conditions => "levels_teams.name = 'Minors'", 
    :include => {:household => {:players => {:team => [:league, :level]}}})
    assert_equal(4, users.size)
  end
  
  def test_events
    events = Event.find(:all, :conditions => "teams.name = 'As'", 
    :include => [{:home_team => [:level, :league]}, {:visitor_team => [:level, :league]}, :location])
    assert_equal(3, events.size)
  end
end