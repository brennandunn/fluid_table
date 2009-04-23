class FluidTable
  class Column
    include Comparable
    include ActionView::Helpers::TagHelper
    
    attr_accessor :identity, :alt_name, :options, :html_options, :proc
    attr_accessor :is_visible, :default_position, :configured_position  # overrides
    
    DefaultOptions = { :default => true }
    
    def initialize(identity, alt_name = nil, options = {}, &proc)
      self.identity     = identity
      self.alt_name     = alt_name
      self.options      = options.reverse_merge(DefaultOptions)
      self.html_options = options.delete(:html) || {}
      self.proc         = proc
    end
    
    def <=>(other_column)
      if position == other_column.position
        return -1 if positioned? && !other_column.positioned?
        return 1 if !positioned? && other_column.positioned?
      end
      position <=> other_column.position
    end
    
    def position
      configured_position || default_position
    end
    
    def positioned?
      !!configured_position
    end
    
    def name
      alt_name || identity.to_s.humanize
    end
    
    def html(scope,table = nil)
      attributes = html_options.is_a?(Proc) ? html_options.call(Context.new(table,scope)) : html_options
      content_tag(:td, interior_content(scope,table), attributes)
    end
    
    def display?
      is_visible.nil? ? options[:default] : is_visible
    end
    
    def reset!
      self.is_visible = self.configured_position = nil
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