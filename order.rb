class Order

  attr_accessor :items, :bonus_card

  def initialize
    @items = []
    @bonus_card = false
  end

  def add_bonus_card
    @bonus_card = true
  end

  def add_item(item)
    @items << item
  end

  def total
    ecumulated_total = sum(@items.map(&:price))
    ecumulated_total += sum(@items.map(&:surcharge))
    ecumulated_total -= calc_discounts if @bonus_card
    ecumulated_total
  end

  private

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
