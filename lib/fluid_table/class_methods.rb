class FluidTable
  module ClassMethods
    
    def define_column(*args, &proc)
      options = args.extract_options!
      identity, alt_name = *args
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