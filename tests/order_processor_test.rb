require 'minitest/autorun'
require_relative '../order_processor'

class OrderProcessorTest < Minitest::Test
  def test_initialize_creates_an_order
    order_processor = OrderProcessor.new
    assert order_processor.order.is_a? Order
  end
end
