require_relative 'test_helper.rb'

class BasicMiningAlgorithmTest <  Minitest::Unit::TestCase
  def test_step_mines_tokens
    trader_list = Factory.create(:trader_list)
    miner = Factory.create(:miner, trader_list: trader_list)
    10.times{miner.step}
    miner.public_tokens.must_be :any?
  end

  def test_miners_are_more_likely_to_add_new_traders
    total_traders = []
    10.times do
      trader_list = Factory.create(:trader_list)
      miner = Factory.create(:miner, trader_list: trader_list)
      12.times{miner.step}
      total_traders << trader_list.traders.length
    end
    total_traders.min.must_be :>, 1
  end
end

