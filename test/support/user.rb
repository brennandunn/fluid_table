class User < Struct.new(:id, :name)
  
  ALL = [
    [1, 'Brennan Dunn'], 
    [2, 'Ken Collins'], 
    [3, 'Brian Knox'], 
    [4, 'Nagu Parasu'] 
  ].map { |arr| new(*arr) }
  
end