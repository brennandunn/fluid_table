require 'test_helper'
require 'action_controller'
require 'action_controller/test_process'

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

class RenderController < ActionController::Base
  def users
    render :file => File.join(File.dirname(__FILE__), 'support', 'users.html.erb')
  end
end

class RenderTableTest < ActionController::TestCase
  tests RenderController
  
  context 'Displaying UsersTable' do
    setup { get :users }
    
    should 'display the header DIV' do
      assert_select 'div', /this is the header/i
    end
    
    should 'display the footer DIV' do
      assert_select 'div', /this is the footer/i
    end
    
    should 'have User:ALL.size rows in the table body' do
      assert_select 'tbody tr', User::ALL.size
    end
     
  end
  
end
