class FluidTable
  module InstanceMethods
    
    def initialize(view,records,render_options={})
      self.view           = view
      self.records        = records
      self.render_options = render_options
      load_customizations
    end
        
    def displayed_columns
      columns.select(&:display?)
    end
    
    def hidden_columns
      columns - displayed_columns
    end
    
    def render
      xml = Builder::XmlMarkup.new
      xml << render_header
      xml.table(table_options || {}) do
        xml.tbody do
          xml << render_table_body
        end
      end
      xml << render_footer
    end
    
    def reset!
      self.class.reset!
    end
    
    # Stub methods
    def customize_column(column) ; column ; end
    def render_header ; '' ; end
    def render_footer ; '' ; end
    
    
    private
  
    def load_customizations
      columns.map { |c| customize_column(c) }
    end
    
    def render_table_body
      records.map do |record|
        content_tag(:tr,render_row(record),render_tr_options(record))
      end.join
    end
    
    def render_row(record)
      displayed_columns.map do |column|
        column.html(record, self)
      end.join
    end
    
    def render_tr_options(record)
      case opt = row_options
        when Proc   then opt.call(Context.new(self,record))
        when Hash   then opt
        else        {}
      end
    end
    
  end
end