class FluidTable
  module ClassMethods
    
    def define_column(identity, alt_name = nil, options = {}, &proc)
      (self.columns ||= Array.new).push(Column.new(identity, alt_name, options, &proc))
    end
    
    def render(view,records)
      new(view,records).render
    end
    
    def valid?
      !columns.empty?
    end
    
  end
end