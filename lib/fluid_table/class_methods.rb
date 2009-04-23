class FluidTable
  module ClassMethods
    
    def define_column(*args, &proc)
      options = [Hash,Proc].include?(args.last.class) ? args.pop : {}
      identity, alt_name = *args
      returning column = Column.new(identity, alt_name, options, &proc) do
        (self.columns ||= Array.new).push(column)
        column.default_position = columns.index(column)
      end
    end
    
    def displayed_columns
      columns.select(&:display?)
    end
    
    def render(view,records)
      new(view,records).render
    end
    
    def reset!
      columns.each(&:reset!)
    end
    
    def valid?
      !columns.empty?
    end
    
  end
end