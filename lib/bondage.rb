$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Bondage
  VERSION = '0.0.1'
  
  def locals
    eval("local_variables").inject({}) {|hash, var|
      hash[var.to_sym] = eval(var)
      hash
    }
  end
  
  def globals
    eval("global_variables").inject({}) {|hash, var|
      hash[var.to_sym] = eval(var)
      hash
    }
  end
  
end