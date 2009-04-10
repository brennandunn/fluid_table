require 'fluid_table/extensions'
require 'fluid_table/class_methods'
require 'fluid_table/instance_methods'
require 'fluid_table/column'

class FluidTable
  include ActionView::Helpers::TagHelper
  
  class_inheritable_array :columns
  class_inheritable_hash :table_options
  attr_accessor :view, :records
  
  extend ClassMethods
  include InstanceMethods
end