require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TableTest < Test::Unit::TestCase

  context 'A FluidTable object' do
    
    should 'have the option of setting attributes to the generated table (as opposed to overwriting #render)' do
      UsersTable.table_options = { :class => 'dataTable' }
      assert_match %r{table class="dataTable"}, render_users
    end
    
    context 'Supplying row (<tr>) options' do
      
      should 'output standard hash options' do
        UsersTable.row_options = { :class => 'foo' }
        assert_match %r{tr class="foo"}, render_users
      end
      
      should 'yield a context object when given a Proc' do
        UsersTable.row_options = Proc.new { |context| { :id => "user_#{context.record.id}" } }
        assert_match %r{tr id="user_#{User::ALL.size}"}, render_users
      end
      
    end
    
  end
  
  def render_users
    UsersTable.render(mock,User::ALL)
  end

end
