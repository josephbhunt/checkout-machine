require 'minitest/autorun'
require_relative '../order'
require_relative '../item'

class OrderTest < Minitest::Test
  def setup
    @order = Order.new
  end

  def test_add_item_adds_an_item_to_the_list
    item = "item"
    @order.add_item(item)
    assert_equal 1, @order.items.count
    assert_equal item, @order.items.first
  end

  def test_total_returns_zero_when_no_items
    assert_equal 0, @order.total
  end

  def test_total_returns_the_sum_of_all_item_prices
    @order.items = [Item.create("Chips"), Item.create("Chips")]
    assert_equal 246, @order.total
  end

  def test_total_returns_the_sum_of_items_with_surcharge
    @order.items = [Item.create("Cigarettes")]
    assert_equal 161, @order.total
  end

  def test_total_returns_sum_of_discounted_salsa
    @order.items = [Item.create("Salsa")]
    @order.add_bonus_card
    assert_equal 228, @order.total
  end

  def test_total_returns_sum_of_discounted_chips
    @order.items = 7.times.map { Item.create("Chips") }
    @order.add_bonus_card
    assert_equal 615, @order.total
  end
end
