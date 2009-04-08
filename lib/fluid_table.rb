require 'fluid_table/extensions'
require 'fluid_table/class_methods'
require 'fluid_table/instance_methods'
require 'fluid_table/column'

class FluidTable
  attr_accessor :view, :records
  
  extend ClassMethods
  include InstanceMethods
end