require 'test_helper'
require 'action_controller'
require 'action_controller/test_process'

require 'support/user'
require 'support/users_table'

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
     
     should 'have stuff' do
       assert_equal 'asdf', @response.body
     end
     
  end
  
end
