require_relative 'test_helper.rb'

class TraderListTest <  Minitest::Unit::TestCase
  def test_trader_list
    trader_list = Factory.create(:trader_list)
    trader_list.traders.must_equal []
  end

  def test_new_partner
    trader_list = Factory.create(:trader_list)
    def trader_list.traders=traders
      @traders = traders
    end
    traders = (0...5).inject([]){|a,b| a << Factory.create(:trader, trader_list: trader_list) }
    known_traders = traders.shuffle!.slice!(0,4)
    unknown_trader = traders.first
    trader_list.new_partner(known_traders).must_equal unknown_trader
  end
end

