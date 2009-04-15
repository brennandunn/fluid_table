class UsersTable < FluidTable
  
  self.table_options = { :class => 'dataTable' }
  
  define_column :id, 'User #'
  
  define_column :name do |user|
    user.name.upcase
  end
  
  # overwrites
  
  def render_header
    content_tag(:div, 'This is the header')
  end
  
  def render_footer
    content_tag(:div, 'This is the footer')
  end
  
end