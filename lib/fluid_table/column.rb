class FluidTable
  class Column
    attr_accessor :identity, :alt_name, :options, :proc, :position
    
    def initialize(identity, alt_name = nil, options = {}, &proc)
      self.identity   = identity
      self.alt_name   = alt_name
      self.options    = options
      self.proc       = proc
    end
    
    def name
      alt_name || identity.to_s.humanize
    end
    
    def html(scope,view = nil)
      %|<td>#{interior_content(scope,view)}</td>|
    end
    
    
    private
    
    def interior_content(scope,view)
      if proc && view
        call_by_arity(scope,view)
      elsif scope.respond_to?(identity)
        scope.send identity
      else
        ''
      end
    end
    
    def call_by_arity(scope,view)
      call_arguments = case proc.arity
        when 1      then [scope]
        # TODO
        else        []
      end
      proc.bind(view).call(*call_arguments)
    end
    
  end
end