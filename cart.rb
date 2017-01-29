class Cart
  attr_accessor :items, :bonus_card

  def initialize(items = [])
    @items = items
  end

  def add_item(item)
    @items << item
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

  def chip_discounts
    discounted = @items.select { |i| i.name == 'Chips' }
    groups_of_three_chips = discounted.count / 3
    Inventory.create('Chips').price * groups_of_three_chips
  end

  def salsa_discounts
    discounted = @items.select { |i| i.name == 'Salsa'}
    discounts = discounted.map { |d| d.price / 2 }
    sum(discounts)
  end

  def sum(collection)
    collection.inject(0) { |sum, i| sum + i }
  end
end
