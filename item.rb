class Item

  attr_accessor :price, :name

  ITEMS = [
    {name: "Chips", price: 123, sku: 200},
    {name: "Salsa", price: 456, sku: 100},
    {name: "Wine", price: 1000, sku: 1000},
    {name: "Cigarettes", price: 111, sku: 500}
  ]

  def self.create(item_name)
    item_attributes = ITEMS.find { |i| i[:name] == item_name }
    new(item_attributes)
  end

  def initialize(attributes = {})
    @name = attributes[:name]
    @price = attributes[:price]
    @sku = attributes[:sku]
  end
end
