module FarMar
  class Market

    def initialize(row)
      @id = row[0]
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
      
    end
  end
end
