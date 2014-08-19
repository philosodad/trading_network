module BasicAlgorithm

  def get_round_partner
    case rand 12
    when 0,1
      new_recruit
    when 2,3,4,5
      new_partner
    else
      @partners.sample
    end
  end

  private

  def trading_step
    partner = get_round_partner
    pass_token(partner, @token_store.sample) if @token_store.any? && partner
  end

  def new_recruit 
    recruit = trader_list.new_recruit self
    add_partner recruit
    recruit
  end

  def new_partner
    partner = @trader_list.new_partner(@partners + [self])
    add_partner partner if partner
    partner
  end
end
