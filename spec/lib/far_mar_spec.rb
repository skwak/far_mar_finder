require 'spec_helper'

describe FarMar do
  let(:finder) { FarMar.new }
  it "responds to markets" do
    finder.should respond_to :markets
  end
  
  it "returns the Market class" do
    finder.markets.should eq Market
  end
  it "responds to vendors" do
    finder.should respond_to :vendors
  end
  
  it "returns the Vendor class" do
    finder.vendors.should eq Vendor
  end
  it "responds to products" do
    finder.should respond_to :products
  end
  
  it "returns the Product class" do
    finder.products.should eq Product
  end
  it "responds to sales" do
    finder.should respond_to :sales
  end
  
  it "returns the Sale class" do
    finder.sales.should eq Sale
  end
end
