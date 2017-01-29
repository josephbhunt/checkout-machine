require './inventory'

class InventoryTest < MiniTest::Test

  def setup
    @inventory = Inventory.new
  end

  def test_find_returns_item_with_matching_sku
    item = @inventory.find(sku: 200)
    item.name = 'Chips'
  end
end
