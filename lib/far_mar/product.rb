module FarMar
  class Product

    attr_reader :id, :name, :vendor_id

    def initialize(row)
      @id = row[0].to_i
      @name = row[1]
      @vendor_id = row[2].to_i
    end

    def self.all
      csv = CSV.read "support/products.csv"
      csv.collect { |row| Product.new(row) }
    end

    def self.find(id)
      self.all.find { |product| product.id == id }
    end

    def self.by_vendor(vendor_id)
      self.all.find_all { |product| product.vendor_id == vendor_id }
    end

    def vendor
      FarMar::Vendor.find(@vendor_id)
    end

    def sales
      FarMar::Sale.all.find_all { |sale| sale.product_id == @id }
    end

    def number_of_sales
      sales.count
    end

  end
end
