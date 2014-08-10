require_relative 'test_helper.rb'

class MinerTest <  Minitest::Unit::TestCase
  def test_new_test
    TraderList.new()
  end
  def test_a_miner_is_a_trader 
    Miner.new(trader_list: TraderList.new()).is_a?(Trader).must_equal true
  end
end
