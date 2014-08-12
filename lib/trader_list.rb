class TraderList
  attr_reader :traders
  def initialize
    @traders = []
  end

  def new_partner known
    (@traders - known).sample
  end
end
