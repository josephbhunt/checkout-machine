class Order

  attr_accessor :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def total
    ecumulated_total = sum(@items.map(&:price))
    ecumulated_total += calc_surcharge
    ecumulated_total -= calc_discounts
  end

  private

  # TODO: This class should not know what items have a surcharge and how much it is.
  def calc_surcharge
    surcharge_items = @items.select { |i| i.name == 'Cigarettes' }
    sum(surcharge_items.map { 50 })
  end

  # TODO: This class should not know about discounts.
  def calc_discounts
    total_discounts = salsa_discounts
    total_discounts += chip_discounts
  end

  # TODO: Refactor
  def chip_discounts
    discounted = @items.select { |i| i.name == 'Chips' }
    groups_of_three_chips = discounted.count / 3
    Item.create('Chips').price * groups_of_three_chips
  end

  # TODO: Refactor
  def salsa_discounts
    discounted = @items.select { |i| i.name == 'Salsa'}
    discounts = discounted.map { |d| d.price / 2 }
    sum(discounts)
  end

  def sum(collection)
    collection.inject(0) { |sum, i| sum + i }
  end
end
