require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TableTest < Test::Unit::TestCase

  context 'A FluidTable object' do
    
    should 'have the option of setting attributes to the generated table (as opposed to overwriting #render)' do
      UsersTable.table_options = { :class => 'dataTable' }
      assert_match %r{table class="dataTable"}, render_users
    end
    
    context 'Ordering of columns' do

      should 'be defaultly positioned in the order of definition' do
        assert_equal 0, UsersTable.columns.first.default_position
        assert_equal UsersTable.columns.size-1, UsersTable.columns.last.default_position
      end

      should 'have the #sort order be identical to the default positioning when there are no custom positions' do
        assert_equal UsersTable.columns, UsersTable.columns.sort
      end

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
