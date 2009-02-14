require File.dirname(__FILE__) + '/spec_helper.rb'

describe "well behaved Bondage", :shared => true do
  it "extends" do
    @object.should be_kind_of(Bondage)
  end
  
  it "look up locals" do
    @object.locals[:x].should == 1
    @object.locals[:y].should == 2
    @object.locals[:z].should be_nil
  end
  
  it "look up globals" do
    @object.globals[:$a].should == $a
    @object.globals[:$b].should == $b
    @object.globals[:$c].should be_nil
  end

  it "look up instance" do
    @object.instvars[:@object].should == @object
  end
  
  it "look up class variables" do
    b = class Blarg
      @@blarg = :bleep
      binding.extend(Bondage)
    end
    b.classvars[:@@blarg].should == :bleep
  end
  
  it "looks up constants" do
    b = class Blarg
      if !defined?(Bleep)
        Bleep = 5
      end
      binding.extend(Bondage)
    end
    b.consts[:Bleep].should == 5
  end
  
  it "supports each on locals" do
    seen = []
    @object.each {|var, value| seen << var}
    seen.should == [:x, :y]
  end
  
  it "can enumerate" do
    @object.find {|var, value| value == 1}.should == [:x, 1]
  end

  it "looks up names" do
    @object[:x].should == 1
    @object[$a].should == $a
    @object[:z].should be_nil
  end
  
  it "sets names" do
    @object[:w] = 5
    eval("w", @object).should == 5
  end
  
  it "sets complex values" do
    a = [1, 2, 3]
    @object[:u] = a
    @object[:u].object_id.should == a.object_id
  end
  
  it "avoids identifier injection" do
    @object[:"raise 'gotcha'; x"].should == nil
  end

  it "avoids identifier injection on assignment" do
    @object[:"raise 'gotcha'; v"] = 6
  end
end

describe "extended" do
  before do
    x = 1
    y = 2
    $a = 3
    $b = 4
    @object = binding.extend(Bondage)
  end

  it_should_behave_like "well behaved Bondage"
end

describe "monkey patched" do
  before :all do
    class Binding
      include Bondage
    end
  end
  
  before do
    x = 1
    y = 2
    $a = 3
    $b = 4
    @object = binding
  end

  it_should_behave_like "well behaved Bondage"
end
