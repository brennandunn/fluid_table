class FluidTable
  class Context < Struct.new(:table,:record)
    
    def method_missing(method, *args, &block)
      return table.view.send(method, *args, &block) if table.view
      super
    end
    
    def view
      table.view if table
    end
    
  end
end