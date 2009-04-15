class FluidTable
  module InstanceMethods
    
    def initialize(view,records,render_options={})
      self.view           = view
      self.records        = records
      self.render_options = render_options
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
    
    def render_header ; '' ; end
    def render_footer ; '' ; end
    
    
    private
    
    def render_table_body
      records.map do |record|
        content_tag(:tr,render_row(record),render_tr_options(record))
      end.join
    end
    
    def render_row(record)
      self.class.columns.map do |column|
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