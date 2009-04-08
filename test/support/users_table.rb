class UsersTable < FluidTable
  
  define_column :id, 'User #'
  
  define_column :name do |user|
    user.name.upcase
  end
  
end