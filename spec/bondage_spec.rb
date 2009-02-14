require File.dirname(__FILE__) + '/spec_helper.rb'

describe Bondage do
  before do
    x = 1
    y = 2
    $a = 3
    $b = 4
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
  
end
