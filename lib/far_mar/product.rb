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
      all.find { |product| product.id == id }
    end

    def self.by_vendor(vendor_id)
      all.find_all { |product| product.vendor_id == vendor_id }
    end

    def self.most_revenue(n)
      all.sort_by(&:revenue).reverse.first(n)
    end

    def vendor
      Vendor.find(@vendor_id)
    end

    def sales
      Sale.by_product(@id)
    end

    def number_of_sales
      sales.count
    end

    def revenue
      @revenue ||= sales.inject(0) { |sum, sale| sum + sale.amount }
      # @revenue ||= sales.collect { |sale| sale.amount }.reduce :+
    end

  end
end
