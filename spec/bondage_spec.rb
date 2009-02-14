require File.dirname(__FILE__) + '/spec_helper.rb'

describe Bondage do
  before do
    x = 1
    y = 2
    $a = 3
    $b = 4
    @@blarg = :bleep
    @object = binding.extend(Bondage)
  end
  
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
  
  it "supports each on locals" do
    seen = []
    @object.each {|var, value| seen << var}
    seen.should == [:x, :y]
  end
  
  it "can enumerate" do
    @object.find {|var, value| value == 1}.should == [:x, 1]
  end
  
end
