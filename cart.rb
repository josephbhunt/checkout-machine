class Cart
  attr_accessor :items, :bonus_card

  def initialize(items = [])
    @items = []
    items.each { |i| add_item(i) }
  end

  def add_item(item)
    raise NotImplementedError
  end

  def price_total
    sum(@items.map(&:price))
  end

  def surcharge_total
    sum(@items.map(&:surcharge))
  end

  def total
    raise NotImplementedError
  end

  def total_items
    @items.count
  end

  private

  def sum(collection)
    collection.inject(0) { |sum, i| sum + i }
  end
end
