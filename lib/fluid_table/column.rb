class FluidTable
  class Column
    include Comparable
    include ActionView::Helpers::TagHelper
    
    attr_accessor :identity, :alt_name, :options, :html_options, :proc, :position
    
    def initialize(identity, alt_name = nil, options = {}, &proc)
      self.html_options = options.is_a?(Hash) ? options.delete(:html) : {}
      self.identity     = identity
      self.alt_name     = alt_name
      self.options      = options
      self.proc         = proc
    end
    
    def <=>(other_column)
      position <=> other_column.position
    end
    
    def position
      configured_position || default_position
    end
    
    def name
      alt_name || identity.to_s.humanize
    end
    
    def html(scope,table = nil)
      argument = options.is_a?(Proc) ? options.call(Context.new(table,scope)) : options
      content_tag(:td, interior_content(scope,table), argument[:html] || {})
    end
    
    
    private
    
    def interior_content(scope,table)
      if proc && table
        call_by_arity(scope,table)
      elsif scope.respond_to?(identity)
        scope.send identity
      else
        ''
      end
    end
    
    def call_by_arity(scope,table)
      call_arguments = case proc.arity
        when 1      then [scope]
        when 2      then [scope, table]
        when 3      then [scope, table, self]
        else        []
      end
      proc.bind(table.view).call(*call_arguments)
    end
    
  end
end