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
  end
end
