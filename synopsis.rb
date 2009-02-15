  require 'lib/bondage'
  
  x = 1
  y = 2
  
  b = binding.extend(Bondage)
  
  # return variable hashes
  p b.locals # => {:x=>1, :y=>2, :b=>#<Binding:0xxxxxxx>}
  p b.globals[:$PROGRAM_NAME] # => "synopis.rb"
  
  # set and retrieve
  b[:z] = ["one", "two", "three"]
  p b[:$LOAD_PATH] # => ["./lib", ...]
  p b[:@pizza] # => nil
  
  # supports Enumerable over locals
  p b.find {|var, value| value == 1 } # => [:x, 1]
  
  # Or if you're feeling really kinky
  class Binding
    include Bondage
  end
