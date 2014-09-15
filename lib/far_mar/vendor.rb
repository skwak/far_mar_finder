module FarMar
  class Vendor

    attr_reader :id, :name, :no_of_employees, :market_id

    def initialize(row)
      @id = row[0].to_i
      @name = row[1]
      @no_of_employees = row[2].to_i
      @market_id = row[3].to_i
    end

    def self.all
      csv = CSV.read "support/vendors.csv"
      csv.collect { |row| Vendor.new(row) }
    end

    def self.find(id)
      self.all.find { |vendor| vendor.id == id}
    end

  end
end
