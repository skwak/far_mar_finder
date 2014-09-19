module FarMar
  class Sale
    CSV_FILE = CSV.read "support/sales.csv"
    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(row)
      @id = row[0].to_i
      @amount = row[1].to_i
      @purchase_time = Time.parse(row[2])
      @vendor_id = row[3].to_i
      @product_id = row[4].to_i
    end

    def self.all
      @data ||= CSV_FILE.collect { |row| Sale.new(row) }
    end

    def self.find(id)
      all.find { |sale| sale.id == id }
    end

    def self.by_vendor(vendor_id)
      all.find_all { |sale| sale if sale.vendor_id == vendor_id }
    end

    def self.by_product(product_id)
      all.find_all { |sale| sale if sale.product_id == product_id }
    end

    def self.between(begin_time, end_time)
      all.select { |sale| (sale.purchase_time > begin_time) && (sale.purchase_time < end_time) }.count
    end

    def vendor
      Vendor.find(@vendor_id)
    end

    def product
      Product.find(@product_id)
    end
  end
end
