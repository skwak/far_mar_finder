require 'spec_helper'

describe FarMar::Vendor do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Vendor).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Vendor.all.count).to eq 2690
    end

    it "responds to 'find'" do
      expect(FarMar::Vendor).to respond_to :find
    end

    it "responds to 'by_market'" do
      expect(FarMar::Vendor).to respond_to :by_market
    end

    it "find the first vendor by market 1" do
      expect(FarMar::Vendor.by_market(100).first.name).to eq "Schiller-Ledner"
    end

    it "responds to most_revenue" do
      expect(FarMar::Vendor).to respond_to :most_revenue
    end

    it "find the top n vendors ranked by total revenue" do
      expect(FarMar::Vendor.most_revenue(10).first.id).to eq 2590
    end

    it "responds to most_items" do
      expect(FarMar::Vendor).to respond_to :most_items
    end

    it "the most items sold for the top vendor is 18" do
      expect(FarMar::Vendor.most_items(10).first.total_items_sold).to eq 18
    end

    it "responds to revenue" do
      expect(FarMar::Vendor).to respond_to :revenue
    end

    it "the total revenue for 2013-11-09 is 8667235" do
      expect(FarMar::Vendor.revenue("2013-11-09")).to eq 8667235
    end

  end

  describe "attributes" do
    let(:vendor) { FarMar::Vendor.find(10) }
    # 10,Kertzmann LLC,11,3

    it "has the id 10" do
      expect(vendor.id).to eq 10
    end
    it "has the name" do
      expect(vendor.name).to eq "Kertzmann LLC"
    end
    it "has the no of employees 11" do
      expect(vendor.no_of_employees).to eq 11
    end
    it "has the market_id 3" do
      expect(vendor.market_id).to eq 3
    end
    it "responds to :revenue" do
      expect(vendor).to respond_to :revenue
    end
    it "has a revenue of 32628" do
      expect(vendor.revenue).to eq 32628
    end
    it "has a revenue of 9333 for 2013-11-09" do
      expect(vendor.revenue("2013-11-09")).to eq 9333
    end
    it "responds to total_items_sold" do
      expect(vendor).to respond_to :total_items_sold
    end
    it "has a total_items_sold of 8" do
      expect(vendor.total_items_sold).to eq 8
    end

  end

  describe "associations" do
    let(:vendor) { FarMar::Vendor.find(1) }

    it "responds to :market" do
      expect(vendor).to respond_to :market
    end

    it "market_id matches the markets id" do
      expect(vendor.market.id).to eq vendor.market_id
    end

    it "responds to :sales" do
      expect(vendor).to respond_to :sales
    end

    it "has 7 sales" do
      expect(vendor.sales.count).to eq 7
    end

    it "responds to products" do
      expect(vendor).to respond_to :products
    end

    it "has 1 products" do
      expect(vendor.products.count).to eq 1
    end

    it "responds to :sales_by_date" do
      expect(vendor).to respond_to :sales_by_date
    end

    it "returns 2 sales for 2013-11-10" do
      date = "2013-11-10"
      expect(vendor.sales_by_date(date).count).to eq 2
    end

    it "responds to :sale_purchase_date" do
      expect(vendor).to respond_to :sale_purchase_date
    end

    it "changes a purchase time into a purchase date" do
      expect(vendor.sale_purchase_date(vendor.sales[0]).to_s).to eq "2013-11-07 00:00:00 -0800"
    end
  end
end
