require_relative 'test_helper.rb'

class BasicAlgorithmTest <  Minitest::Unit::TestCase
  def test_step
    trader_list = Factory.create(:trader_list)
    existing_partner = Factory.create(:trader, trader_list: trader_list)
    Factory.create(:trader, trader_list: trader_list) 
    trader = Factory.create(:trader, partner: existing_partner, trader_list: trader_list)
    token = Factory.create(:token)
    trader.take_token token
    trader.step
    potential_partners = (trader_list.traders - [trader])
    potential_partners.map{|p| p.public_tokens.include? token}.must_be :include?, true
  end

  def test_get_round_partner_creates_new_traders
    trader_list = Factory.create(:trader_list)
    trader = Factory.create(:trader, trader_list: trader_list)
    1000.times {trader.get_round_partner}
    trader_list.traders.length.must_be_close_to 160,40
  end

  def test_get_round_partner_options
    rounds = 100
    results = [] 
    trader_list = Factory.create(:trader_list)
    def trader_list.traders= traders  
      @traders = traders
    end
    initial_trader = Factory.create(:trader, trader_list: trader_list)
    initial_partner = Factory.create(:trader, trader_list: trader_list)
    rounds.times do
      trader_list.traders = [initial_trader, initial_partner]
      trader = Factory.create(:trader, trader_list: trader_list, partner: initial_partner)
      results << trader.get_round_partner
    end 
    chose_existing_partner = results.select{|result| result == initial_partner}.length
    chose_existing_partner.must_be_close_to rounds/2, rounds * 0.10
    chose_from_available = results.select{|result| result == initial_trader}.length
    chose_from_available.must_be_close_to rounds/3, rounds * 0.10
  end
end

