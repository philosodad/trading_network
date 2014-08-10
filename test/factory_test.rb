require_relative 'test_helper.rb'

class FactoryTest <  Minitest::Unit::TestCase
  def test_makes_new_objects 
    Factory.create(:miner, trader_list: TraderList.new()).class.must_equal Miner
    Factory.create(:token).class.must_equal Token
  end
end

