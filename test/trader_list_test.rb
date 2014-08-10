require_relative 'test_helper.rb'

class TraderListTest <  Minitest::Unit::TestCase
  def test_trader_list
    TraderList.new(:a)
  end
end

