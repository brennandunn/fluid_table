class FluidTable
  module InstanceMethods
    
    def initialize(view,records)
      self.view     = view
      self.records  = records
    end
    
    def render
      returning xml = Builder::XmlMarkup.new do
        xml << render_header
        xml.table(table_options || {}) do
          xml.tbody do
            xml << render_table_body
          end
        end
        xml << render_footer
      end
    end
    
    def render_header ; '' ; end
    def render_footer ; '' ; end
    
    private
    
    def render_table_body
      records.map do |record|
        %|<tr>#{render_row(record)}</tr>|
      end.join
    end
    
    def render_row(record)
      self.class.columns.map do |column|
        column.html(record, self)
      end.join
    end
    
  end
end