class FluidTable
  module InstanceMethods
    
    def initialize(view,records)
      self.view     = view
      self.records  = records
    end
    
    def render
      xml = Builder::XmlMarkup.new
      xml.table do
        xml.tbody do
          xml << render_table_body
        end
      end
    end
    
    
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