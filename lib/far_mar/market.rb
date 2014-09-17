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
      vendors.collect { |vendor| vendor.products }.flatten
    end

    def min_revenue(date=nil)
      vendors.min_by { |vndr| vndr.revenue(date) }.revenue(date)
    end

    def preferred_vendor(date=nil)
      vendors.max_by { |vendor| vendor.revenue(date) }
    end

    def worst_vendor(date=nil)
      vendors.select { |vendor| vendor.revenue(date) == min_revenue(date) }
      # Below only returns one Vendor instance (when there could be multiples)
      # vendors.min_by { |vendor| vendor.revenue(date) }
    end

  end
end
