class Order

  attr_accessor :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def total
    @items.inject(0){|sum, i| sum + i.price}
  end
end
