require 'spec_helper'
describe FarMar::Market do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Market).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Market.all.count).to eq 500
    end

    it "responds to 'find'" do
      expect(FarMar::Market).to respond_to :find
    end

    it "responds to 'search'" do
      expect(FarMar::Market).to respond_to :search
    end

    it "'search(\"school\")' should return" do
      expect(FarMar::Market.search("school").count).to eq 3
    end

  end

  describe "attributes" do
    let(:market) { FarMar::Market.find(1) }
    # 1,People's Co-op Farmers FarMar::Market,30,Portland,Multnomah,Oregon,97202

    it "has the id 1" do
      expect(market.id).to eq 1
    end

    it "has the name 'People's Co-op Farmers FarMar::Market'" do
      expect(market.name).to eq "People's Co-op Farmers Market"
    end

    it "has the address '30th and Burnside'" do
      expect(market.address).to eq "30th and Burnside"
    end

    it "has the city 'Portland'" do
      expect(market.city).to eq "Portland"
    end
    it "has the county 'Multnomah'" do
      expect(market.county).to eq "Multnomah"
    end
    it "has the state 'Oregon'" do
      expect(market.state).to eq "Oregon"
    end
    it "has the zip '97202'" do
      expect(market.zip).to eq "97202"
    end

  end

  describe "instance methods" do
    let(:market) { FarMar::Market.find(1) }
    it "responds to vendors" do
      expect(FarMar::Market.new({})).to respond_to :vendors
    end

    it "finds the vendors" do
      expect(market.vendors.first.id).to eq 1
    end

    it "responds to products" do
      expect(FarMar::Market.new({})).to respond_to :products
    end

    it "finds the products" do
      expect(market.products.first.id).to eq 1
    end

    it "responds to preferred_vendor" do
      expect(FarMar::Market.new({})).to respond_to :preferred_vendor
    end

    it "finds the preferred vendor" do
      expect(market.preferred_vendor.id).to eq 5
    end

    it "finds the preferred vendor for date" do
      date = "2013-11-13"
      expect(market.preferred_vendor(date).id).to eq 1
    end

    it "responds to worst_vendor" do
      expect(FarMar::Market.new({})).to respond_to :worst_vendor
    end

    it "finds the worst vendor or vendors" do
      expect(market.worst_vendor[0].id).to eq 6
    end

  end
end
