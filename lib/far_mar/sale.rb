module FarMar
  class Sale

    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(row)
      @id = row[0].to_i
      @amount = row[1].to_i
      @purchse_time = row[2]
      @vendor_id = row[3].to_i
      @product_id = row[4].to_i
    end

    def self.all
      csv = CSV.read "support/sales.csv"
      csv.collect { |row| Sale.new(row) }
    end

    def self.find(id)
      self.all.find { |sale| sale.id == id }
    end
  end
end
