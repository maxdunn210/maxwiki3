require 'test_helper'

class RegAdminTest < ActionController::TestCase
  fixtures :adults, :players, :households, :doctors, :wikis, :system

  def setup
    @controller = RegAdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    super
  end

  def test_paid
  
    get :index
    assert_redirected_to :controller => 'user', :action => 'login'
    
    login_admin
    get :index
    assert_template 'index'

    assert_tag(:tag => 'div', :attributes => {:id => "middle_column"},
      :content => 'Total users paid: 0')    
  end

end
