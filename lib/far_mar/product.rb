module FarMar
  class Product
    CSV_FILE = CSV.read "support/products.csv"
    attr_reader :id, :name, :vendor_id

    def initialize(row)
      @id = row[0].to_i
      @name = row[1]
      @vendor_id = row[2].to_i
    end

    def self.all
      @data ||= CSV_FILE.collect { |row| Product.new(row) }
    end

    def self.find(id)
      self.all.find { |product| product.id == id }
    end

    def self.by_vendor(vendor_id)
      self.all.find_all { |product| product.vendor_id == vendor_id }
    end

    def self.most_revenue(n)
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

    def revenue
      @revenue ||= sales.inject(0) { |sum, sale| sum + sale.amount }
    end

  end
end
