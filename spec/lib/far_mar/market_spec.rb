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
    it "responds to in_name?" do
      expect(FarMar::Market.new({})).to respond_to :in_name?
    end

    it "finds a search term in the market name" do
      expect(market.in_name?("farmer").to_s).to eq "farmer"
    end

    it "responds to in_vendor_names?" do
      expect(FarMar::Market.new({})).to respond_to :in_vendor_names?
    end

    it "finds a search term in the market's vendor names" do
      expect(market.in_vendor_names?("sons").market_id).to eq 1
    end

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

    it "responds to min_revenue" do
      expect(FarMar::Market.new({})).to respond_to :min_revenue
    end

    it "responds to max_revenue" do
      expect(FarMar::Market.new({})).to respond_to :max_revenue
    end

    it "returns a min_revenue" do
      expect(market.min_revenue).to eq 2977
    end

    it "returns a max_revenue" do
      expect(market.max_revenue).to eq 61749
    end

    it "returns a max_revenue for a date" do
      date = "2013-11-13"
      expect(market.max_revenue(date)).to eq 9588
    end

    it "returns a min_revenue for a date" do
      date = "2013-11-13"
      expect(market.min_revenue(date)).to eq 0
    end

    it "responds to preferred_vendor" do
      expect(FarMar::Market.new({})).to respond_to :preferred_vendor
    end

    it "finds the preferred vendor" do
      expect(market.preferred_vendor[0].id).to eq 5
    end

    it "finds the preferred vendor for date" do
      date = "2013-11-13"
      expect(market.preferred_vendor(date)[0].id).to eq 1
    end

    it "responds to worst_vendor" do
      expect(FarMar::Market.new({})).to respond_to :worst_vendor
    end

    it "finds the worst vendor or vendors" do
      expect(market.worst_vendor[0].id).to eq 6
    end

    it "finds the worst vendors for date" do
      date = "2013-11-13"
      expect(market.worst_vendor(date).count).to eq 3
    end

  end
end
