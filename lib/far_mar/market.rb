module FarMar
  class Market
    CSV_FILE = CSV.read "support/markets.csv"
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
      CSV_FILE.collect { |row| Market.new(row) }
    end

    def self.find(id)
      self.all.find { |market| market.id == id }
    end

    def self.search(search_term)
      self.all.select do |market|
        market.name.downcase.match(search_term) || (market.vendors.find { |vendor| vendor.name.downcase.match(search_term) })
      end
    end

    def vendors
      FarMar::Vendor.all.find_all { |vendor| vendor if vendor.market_id == @id }
    end

    def products
      vendors.collect {|vendor| vendor.products}.flatten
    end

    def preferred_vendor
      vendors.max_by { |vendor| vendor.revenue }
    end

  end
end
