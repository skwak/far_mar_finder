# FarMar Finder

In this assignment we will be creating an application to look up Farmers Markets and their related vendors, products, and sales. We will use CSV files as our database.

### Getting Started

1. Pair up!
2. The individual closest to the center of the room will fork the repo: [https://github.com/Ada-Developers-Academy/far_mar](https://github.com/Ada-Developers-Academy/far_mar)
3. Add the second individual as a collaborator
4. Both individuals will clone the repo `git clone [YOUR FORKED REPO URL]`
5. Both individuals cd into the dir created `cd far_mar`
6. Both individuals install needed tools (in Terminal.app)

------
    gem install rspec
    gem install simplecov
------

**Start building! (but read on for more info)**

### Data

There are several CSV data files:

    /support/markets.csv
    /support/products.csv
    /support/vendors.csv
    /support/sales.csv

### Expectations

Build classes to query the CSV data including objects and methods listed below. Before going too deeply into the methods listed, start by building a system to read the csv files and turn each row of data into an instance of the corresponding ruby class.

To manage our data classes we will use a file named `/lib/far_mar.rb`

    require 'csv'
    require 'time'
    require 'lib/market'
    # ... require all needed classes

Each of the classes you build will be nested under the `FarMar` module.

```ruby
module FarMar
  class Market
    # Your code goes here
  end
end
```

All this nesting does is namespacing. This is different from inheritance, all this is doing is making the classes we make not collide with a class that another gem might use.
For example `Sale` could easily be defined in many other code bases, but since we namespace is as `FarMar::Sale` it is now more uniquely named.

See below for full description of methods to create.

### Assignment

**For each of the data classes build the following methods:**

- `self.all` - returns all rows of the CSV file as objects
- `self.find(id)` - returns the row where the ID field matches the argument

**Additional FarMar::Market Methods**

- `vendors` - returns a collection of `FarMar::Vendor` instances that are associated with the market by the market_id field.

**Additional FarMar::Vendor Methods**

- `market` - returns the `FarMar::Market` instance that is associated with this vendor using the `FarMar::Vendor` `market_id` field
- `products` - returns a collection of `FarMar::Product` instances that are associated with market by the `FarMar::Product` `vendor_id` field.
- `sales` - returns a collection of `FarMar::Sale` instances that are associated with market by the `vendor_id` field.
- `revenue` - returns the the sum of all of the vendor's sales (in cents)
- `self.by_market(market_id)` - returns all of the vendors with the given `market_id`

**Additional FarMar::Product Methods**

- `vendor` - returns the `FarMar::Vendor` instance that is associated with this vendor using the `FarMar::Product` `vendor_id` field
- `sales` - returns a collection of `FarMar::Sale` instances that are associated with market using the `FarMar::Sale` `product_id` field.
- `number_of_sales` - returns the number of times this product has been sold.
- `self.by_vendor(vendor_id)` - returns all of the products with the given `vendor_id`

**Additional FarMar::Sale Methods**

- `vendor` - returns the `FarMar::Vendor` instance that is associated with this sale using the `FarMar::Sale` `vendor_id` field
- `product` - returns the `FarMar::Product` instance that is associated with this sale using the `FarMar::Sale` `product_id` field
- `self.between(beginning_time, end_time)` - returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments


**Extra Credit Methods**

- `random` returns a random instance

**Extra Credit FarMar::Market Methods**

- `products` returns a collection of `FarMar::Product` instances that are associated to the market through the `FarMar::Vendor` class.
- `self.search(search_term)` returns a collection of `FarMar::Market` instances where the market name or vendor name contain the `search_term`. For example `FarMar::Market.search('school')` would return 3 results, one being the market with id 75 (Fox School Farmers FarMar::Market).
- `prefered_vendor` - returns the vendor with the highest revenue
- `prefered_vendor(date)` - returns the vendor with the highest revenue for the given date
- `worst_vendor` - returns the vendor with the lowest revenue
- `worst_vendor(date)` - returns the vendor with the lowest revenue on the given date

**Extra Credit FarMar::Vendor Methods**

- `self.most_revenue(n)` returns the top n vendor instances ranked by total revenue
- `self.most_items(n)` returns the top n vendor instances ranked by total number of items sold
- `self.revenue(date)` returns the total revenue for that date across all vendors
- `revenue(range_of_dates)` returns the total revenue for that vendor across several dates
- `revenue(date)` returns the total revenue for that specific purchase date

**Extra Credit FarMar::Product Methods**

- `self.most_revenue(n)` returns the top n products instances ranked by total revenue
- `best_day` returns a `Date` object with the most sales for the given product using the `FarMar::Sale` purchase_time

**Extra Credit FarMar::Sale Methods**

- `self.best_day` returns a `Date` object with the most sales overall.


### Testing

To run our test suite use:

    rspec -c

Our test suite will run tests to ensure that *some* of our required methods are implemented correctly.

Note: It will be best to create the basic file for the four supporting classes before running our tests

    class FarMar::Market

    end

and requiring them in `/lib/far_mar.rb`.

## Evaluation

You will be evaluated on:

- Running `rspec` from Terminal with no failures
- Demonstrating, in IRB, a few of the methods listed above (asked at random).
- Code quality (is your code organized and logical)
- Extra credit for additional methods to add neat functionality
- Extra credit for writing additional specs

---------

---------

## More Info

### Classes

Our supporting classes will also live in the `/lib` dir.

#### FarMar::Market

The FarMar::Market data, in order in the CSV, consists of:

1. ID
2. Name
3. Address
4. City
5. County
6. State
7. Zip

An individual market has many vendors

#### FarMar::Vendor

The FarMar::Vendor data, in order in the CSV, consists of:

1. ID
2. Name
3. No. of Employees
4. Market_id

Each vendor belongs to a market, the market_id field relates to the FarMar::Market ID field.
Each vendor has many products they sell.

#### FarMar::Product

The FarMar::Product data, in order in the CSV, consists of:

1. ID
2. Name
3. Vendor_id

Each product belongs to a vendor, the vendor_id field relates to the FarMar::Vendor ID field.

#### FarMar::Sale

The FarMar::Sale data, in order in the CSV, consists of:

1. ID
2. Amount (in cents)
3. Purchase Time
4. Vendor_id
5. Product_id

Each sale belongs to a vendor AND an product, the vendor_id and product_id fields relates to the FarMar::Vendor and FarMar::Product ID fields

# Silver

- `self.find_by_x(match)` - where X is an attribute, returns a single instance whose X attribute case-insensitive attribute matches the match parameter. For instance, FarMar::Vendor.find_by_name("windler inc") could find a FarMar::Vendor with the name attribute "windler inc" or "Windler Inc".
- `self.find_all_by_x(match)` - works just like `find_by_x` but returns a collection containing all possible matches. For example `FarMar::Market.find_by_state("WA")` could return all of the FarMar::Market object with `"WA"` in their state field.
