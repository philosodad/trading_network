class Trader
  @@id = 0
  attr_reader :trader_list, :id

  def self.reset
    @@id = 0
  end

  def initialize opts={}
    raise ArgumentError, "trader must be initialized with trader list" unless opts[:trader_list].is_a? TraderList
    if opts[:algorithm]
      set_algorithm( opts[:algorithm])
    else
      set_algorithm (:basic_algorithm)
    end
    @id = @@id
    @@id = @@id + 1
    @trader_list = opts[:trader_list]
    @trader_list.traders << self
    @partners = []
    add_partner opts[:partner] if opts[:partner]
  end

  def partners?
    @partners.any?
  end

  def has_partner partner
    @partners.include?(partner)
  end

  def add_partner partner
    @partners << partner
  end

  private

  def set_algorithm algorithm
    algorithm = Factory.constantize(algorithm)
    Trader.include algorithm
  end

end
