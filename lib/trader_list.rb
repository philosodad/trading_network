class TraderList
  class << self
    def trader_class
      Trader
    end
  end

  attr_reader :traders
  def initialize
    @traders = []
  end

  def new_partner known
    (@traders - known).sample
  end

  def new_recruit partner
    self.class.trader_class.new trader_list: self, partner: partner
  end
end
