require_relative 'test_helper.rb'

class MinerTest <  Minitest::Unit::TestCase

  def test_a_miner_is_a_trader 
    Miner.new(trader_list: TraderList.new()).is_a?(Trader).must_equal true
  end

  def test_miner_is_initiated_with_mining_algorithm
    trader_list = Factory.create(:trader_list)   
    miner = Factory.create(:miner, trader_list: trader_list)
    miner.class.algorithm.must_equal BasicAlgorithm
    miner.class.mining_algorithm.must_equal BasicMiningAlgorithm
  end
end
