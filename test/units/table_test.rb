require File.join(File.dirname(__FILE__), '..', 'test_helper')
require File.join(File.dirname(__FILE__), '..', 'support', 'users_table')

class TableTest < Test::Unit::TestCase

  context 'A FluidTable object' do
    
    should 'have the option of setting attributes to the generated table (as opposed to overwriting #render)' do
      UsersTable.table_options = { :class => 'dataTable' }
      assert_match %r{table class="dataTable"}, UsersTable.render(mock,[])
    end
    
  end

end
