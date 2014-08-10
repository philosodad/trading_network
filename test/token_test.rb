require_relative 'test_helper.rb'

class TokenTest <  Minitest::Unit::TestCase
  def test_has_a_guid 
    Factory.create(:token).id.wont_be :nil?
  end
end

