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

  def discount_total
    total_discounts = salsa_discounts
    total_discounts += chip_discounts
  end

  def total(apply_discounts)
    ecumulated_total = price_total
    ecumulated_total += surcharge_total
    ecumulated_total -= discount_total if apply_discounts
    ecumulated_total
  end

  def total_items
    @items.count
  end

  private

  def sum(collection)
    collection.inject(0) { |sum, i| sum + i }
  end
end
