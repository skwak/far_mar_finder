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
      @data ||= CSV_FILE.collect { |row| Market.new(row) }
    end

    def self.find(id)
      all.find { |market| market.id == id }
    end

    def self.search(search_term)
      all.select do |market|
        market.in_name?(search_term) || market.in_vendor_names?(search_term)
      end
    end

    def in_name?(search_term)
      name.downcase.match(search_term)
    end

    def in_vendor_names?(search_term)
      vendors.find { |vendor| vendor.name.downcase.match(search_term) }
    end

    def vendors
      Vendor.by_market(@id)
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
