$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Bondage
  VERSION = '0.0.1'
  
  # Hash of local variables
  def locals; list_all :local_variables; end
  # Hash of global variables (with '$')
  def globals; list_all :global_variables; end
  # Hash of instance variables (with '@')
  def instvars; list_all :instance_variables; end
  # Hash of class variables (with '@@')
  def classvars; list_all :class_variables; end
  # Hash of constants
  def consts; list_all :constants; end
  
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

  # Assign the variable within the binding
  # * If your implementation supports ObjectSpace, this is relatively safe.
  #   This preserves object identity.  (Copy by reference.)
  # * If not, the right-hand-side gets it's string value eval'ed
  def []=(name, value)
    if defined?(ObjectSpace)
      eval("#{sanitize(name)} = ObjectSpace._id2ref(#{value.object_id})")
    else
      eval("#{sanitize(name)} = #{value}")
    end
  end

  private
  def list_all(kind)
    eval(kind.to_s).inject({}) {|hash, var|
      hash[var.to_sym] = lookup(var)
      hash
    }
  end
  
  def sanitize(name)
    name.to_s.gsub(/[^$@\w]/, '_')
  end
end