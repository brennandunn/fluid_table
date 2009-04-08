require 'rubygems'
require 'active_support'
require 'action_view'
require 'test/unit'
require 'shoulda'
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'fluid_table'

class Test::Unit::TestCase
  
  def test_true
  end
  
  private
    def assert_equal_html(expected, actual)
      assert_equal expected.strip.gsub(/\n\s*/, ''), actual.strip.gsub(/\n\s*/, '')
    end
end
