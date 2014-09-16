module FarMar
  class Market

    attr_reader :id, :name, :address, :city, :county, :state, :zip

    def initialize(row)
      @id = row[0].to_i
      @name = row[1]
      @address = row[2]
      @city = row[3]
      @county = row[4]
      @state = row[5]
      @zip = row[6]
    end

    def self.all
      csv = CSV.read "support/markets.csv"
      csv.collect { |row| Market.new(row) }
    end

    def self.find(id)
      self.all.find { |market| market.id == id}
    end

    def vendors
      FarMar::Vendor.all.find_all {|vendor| vendor if vendor.market_id == @id}
    end

    def products
      vendors.collect {|vendor| vendor.products}.flatten
    end

  end
end
