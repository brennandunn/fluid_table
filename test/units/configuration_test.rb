###
#   NOTICE: Rather than bundling Configurator (or another means of having configurable options)  
#   I'm taking the route of simply stubbing expectations with Mocha.
###

require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ConfigurationTest < Test::Unit::TestCase
  
  def setup
    @table = UsersTable.new(nil,nil)
  end
  
  # Columns are stored at the class level and are thus shared by all tests. Must reset! each column 
  # to prevent unexpected results.
  def teardown
    @table.reset!
  end
  
  context "Determining a column's default visibility" do
    
    setup do
      @displayed_column = get_column(:displayed_column)
      @hidden_column = get_column(:hidden_column)
    end
    
    should 'default to TRUE for a column display' do
      assert @displayed_column.display?
    end
    
    should "allow for a column's definition to default display to FALSE" do
      assert ! @hidden_column.display?
    end
    
    should 'include correct columns when returning from #displayed_columns or #hidden_columns' do
      assert @table.displayed_columns.include?(@displayed_column)
      assert ! @table.displayed_columns.include?(@hidden_column)
      assert @table.hidden_columns.include?(@hidden_column)
      assert ! @table.hidden_columns.include?(@displayed_column)
    end
    
  end
  
  context 'When overriding position or visibility through some sort of configuration' do
    
    should 'call #customize_column with each column object on table instantiation' do
      @table.columns.each do |column|
        @table.expects(:customize_column).with(column)
      end
      @table.send :load_customizations
    end
    
    should 'override default column visibility settings when instructed' do
      column = get_column(:age)
      assert @table.displayed_columns.include?(column)
      transform_column(column = get_column(:age), false)
      @table.send :load_customizations
      assert ! @table.displayed_columns.include?(column)
    end
    
  end
  
  private
  
  def get_column(identity)
    @table.columns.detect { |c| c.identity == identity }
  end
  
  def transform_column(column, is_visible = true, position = nil)
    column.is_visible = is_visible
    column.configured_position = position
  end
    
end