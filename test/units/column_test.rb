require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TestTable < FluidTable
  define_column :id, 'User #'
  define_column :name
end

class ColumnTest < Test::Unit::TestCase

  context 'Constructing column objects' do
    
    setup do
      @id_column = FluidTable::Column.new(:id)
      @name_column = FluidTable::Column.new(:name, 'User Name')
      @google_column = FluidTable::Column.new(:google) { link_to_google }
    end
    
    should "respond to it's identity" do
      assert_equal :id, @id_column.identity
    end
    
    should 'attempt to create a humanized string from the identity if an alt_name is not present' do
      assert_equal 'User Name', @name_column.name
      assert_equal 'Id', @id_column.name
    end
    
    should 'wrap output within a table cell' do
      assert_equal_html '<td></td>', @id_column.html(mock)
    end
    
    should 'attempt to get cell content from scope object when proc is not available' do
      assert_equal_html '<td>John Doe</td>', @name_column.html(mock({ :name => 'John Doe' }))
    end
    
    should "call a column's proc (if exists) against the scope of the current view" do
      view = mock({ :link_to_google => 'http://google.com' })
      assert_equal_html '<td>http://google.com</td>', @google_column.html(nil,view)
    end
    
  end
  
  context 'Columns within a FluidTable' do
    
    should 'not be valid? unless at least one column is defined' do
      assert ! TestTable.columns.empty?
      assert TestTable.valid?
      TestTable.stubs(:columns).returns([])
      assert ! TestTable.valid?
    end
    
  end

end
