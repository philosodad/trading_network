module BasicMiningAlgorithm
 
  def get_round_partner
    case rand 12
    when 0,1,2,3
      new_recruit
    when 4,5,6
      new_partner
    else
      @partners.sample
    end
  end

  def mining_step
    take_token Token.new
  end

end
