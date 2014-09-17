module FarMar
  class Vendor
    CSV_FILE = CSV.read "support/vendors.csv"
    attr_reader :id, :name, :no_of_employees, :market_id

    def initialize(row)
      @id = row[0].to_i
      @name = row[1]
      @no_of_employees = row[2].to_i
      @market_id = row[3].to_i
    end

    def self.all
      CSV_FILE.collect { |row| Vendor.new(row) }
    end

    def self.find(id)
      self.all.find { |vendor| vendor.id == id }
    end

    def self.by_market(market_id)
      self.all.find_all { |vendor| vendor if vendor.market_id == market_id }
    end

    def market
      FarMar::Market.find(@market_id)
    end

    def sales
      FarMar::Sale.all.find_all {|sale| sale if sale.vendor_id == @id}
    end

    def products
      FarMar::Product.all.find_all {|product| product if product.vendor_id == @id}
    end

    def revenue
      sales.inject(0) { |sum, sale| sum + sale.amount }
    end

  end
end
