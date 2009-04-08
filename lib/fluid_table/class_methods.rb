class FluidTable
  module ClassMethods
    
    def columns
      @columns ||= Array.new
      @columns
    end
    
    def define_column(*args)
      columns.push(Column.new(*args))
    end
    
    def render(view,records)
      new(view,records).render
    end
    
    def valid?
      !columns.empty?
    end
    
  end
end