require_relative 'test_helper.rb'

class TraderTest <  Minitest::Unit::TestCase
  def test_trader_cannot_initialize_without_trader_list
    assert_raises(ArgumentError){Factory.create(:trader)}
  end

  def test_trader_initializes_without_partners
    trader = Factory.create(:trader, trader_list: TraderList.new())
    trader.partners?.must_equal false
  end

  def test_trader_initialized_with_a_partners_has_that_partner
    trader = Factory.create(:trader, trader_list: TraderList.new())
    trader2 = Factory.create(:trader, partner: trader, trader_list: TraderList.new())
    trader3 = Factory.create(:trader, partner: trader, trader_list: TraderList.new())
    trader2.partners?.must_equal true
    trader2.has_partner(trader).must_equal true
    trader2.has_partner(trader3).must_equal false
  end

  def test_trader_has_a_trader_list
    trader_list = Factory.create(:trader_list)
    trader = Factory.create(:trader, trader_list: trader_list)
    trader.trader_list.class.must_equal TraderList
  end

  def test_sets_ids_in_sequence
    Trader.reset
    trader_list = Factory.create(:trader_list)
    100.times do
      Factory.create(:trader, trader_list: trader_list)
    end
    trader_list.traders.last.id.must_equal 99
    trader_list.traders.first.id.must_equal 0
    trader_list.traders.length.must_equal 100
    Trader.id.must_equal 100
  end

  def test_can_take_a_token
    trader_list = Factory.create(:trader_list)
    trader = Factory.create(:trader, trader_list: TraderList.new())
    trader2 = Factory.create(:trader, partner: trader, trader_list: TraderList.new())
    token = Factory.create(:token)
    trader2.pass_token(trader, token)
    trader.public_tokens.must_be :include?, token
  end

  def test_has_a_public_key
    trader_list = Factory.create(:trader_list)
    trader = Factory.create(:trader, trader_list: TraderList.new())
    trader.public_key.wont_be :nil?
  end
end

