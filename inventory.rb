require './item'

class Inventory
  ITEMS = [
    {name: "Chips", price: 123, sku: 200},
    {name: "Salsa", price: 456, sku: 100},
    {name: "Wine", price: 1000, sku: 1000},
    {name: "Cigarettes", price: 111, sku: 500, surcharge: 50}
  ]

  def self.create(item_name)
    item_attributes = ITEMS.find { |i| i[:name] == item_name }
    Item.new(item_attributes)
  end

  def initialize
  end

  def find(search_attributes = {})
    item_attributes = ITEMS.find do |i|
      result = search_attributes.keys.all? do |key|
        i[key] == search_attributes[key]
      end
    end
    Item.new(item_attributes)
  end
end
