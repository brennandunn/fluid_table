class FluidTable
  module InstanceMethods
    
    def initialize(view,records)
      self.view     = view
      self.records  = records
    end
    
    def render
      render_table_body
    end
    
    
    private
    
    def render_table_body
      records.map do |record|
        %|\n<tr>\n#{render_row(record)}\n</tr>|
      end.join
    end
    
    def render_row(record)
      self.class.columns.map do |column|
        column.html(record, self)
      end.join("\n")
    end
    
  end
end