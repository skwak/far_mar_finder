module FarMar
  class Vendor
    CSV_FILE = CSV.read "support/vendors.csv"
    attr_reader :id, :name, :no_of_employees, :market_id

    def initialize(row)
      @id = row[0].to_i
      @name = row[1]
      @no_of_employees = row[2].to_i
      @market_id = row[3].to_i
    end

    def self.all
      @data ||= CSV_FILE.collect { |row| Vendor.new(row) }
    end

    def self.find(id)
      all.find { |vendor| vendor.id == id }
    end

    def self.by_market(market_id)
      all.find_all { |vendor| vendor if vendor.market_id == market_id }
    end

    def self.most_revenue(n)
      all.sort_by(&:revenue).last(n).reverse
    end

    def self.most_items(n)
      all.sort_by(&:total_items_sold).last(n).reverse
    end

    def self.revenue(date)
      all.collect{ |vendor| vendor.revenue(date) }.reduce :+
    end

    def market
      Market.find(@market_id)
    end

    def sales
      Sale.by_vendor(@id)
    end

    def products
      Product.by_vendor(@id)
    end

    def sales_by_date(date)
      sales.select do |sale|
        sale_purchase_date(sale) == Time.parse(date)
      end
    end

    def sale_purchase_date(sale)
      Time.new(sale.purchase_time.year, sale.purchase_time.month, sale.purchase_time.day)
    end

    def revenue(date=nil)
      if date
        sales_by_date(date).inject(0) { |sum, sale| sum + sale.amount }
      else
        @total_revenue ||= sales.inject(0) { |sum, sale| sum + sale.amount }
      end
    end

    def total_items_sold
      @total_items_sold ||= sales.count
    end
  end
end
