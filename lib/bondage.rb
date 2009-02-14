$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Bondage
  VERSION = '0.0.1'
  
  include Enumerable
  
  def self.lister(name, kind)
    define_method(name) do
      eval(kind.to_s).inject({}) {|hash, var|
        hash[var.to_sym] = eval(var)
        hash
      }
    end
  end

  lister :locals, :local_variables
  lister :globals, :global_variables
  lister :instvars, :instance_variables
  lister :classvars, :class_variables
  
  def each(&proc)
    locals.each(&proc)
  end
  
  def [](symbol)
    begin
      eval(symbol.to_s)
    rescue NameError
      return nil
    end
  end
end