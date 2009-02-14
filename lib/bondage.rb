$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Bondage
  VERSION = '0.0.1'
  
  class << self
    private
    def lister(name, kind)
      define_method(name) do
        eval(kind.to_s).inject({}) {|hash, var|
          hash[var.to_sym] = lookup(var)
          hash
        }
      end
    end
  end

  lister :locals, :local_variables
  lister :globals, :global_variables
  lister :instvars, :instance_variables
  lister :classvars, :class_variables
  lister :consts, :constants
  
  # Iterator over locals; base for Enumerable methods.
  def each(&proc)
    locals.each(&proc)
  end
  include Enumerable
  
  # Return the value of the symbol in the binding.
  def lookup(name)
    begin
      eval(sanitize(name));
    rescue NameError
      return nil
    end
  end
  
  alias_method :[], :lookup

  # Assign the symbol within the binding
  # * If your implementation supports ObjectSpace, this is relatively safe
  # * If not, the right-hand-side gets it's string value eval'ed
  def []=(symbol, value)
    if defined?(ObjectSpace)
      eval("#{sanitize(symbol)} = ObjectSpace._id2ref(#{value.object_id})")
    else
      eval("#{sanitize(symbol)} = #{value}")
    end
  end

  private
  def sanitize(name)
    name.to_s.gsub(/[^$@\w]/, '_')
  end
end