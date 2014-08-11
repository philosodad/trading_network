class Trader
  attr_reader :trader_list, :id

  class << self
    attr_reader :id, :algorithm_set, :algorithm
    def reset
      @id = 0
      @algorithm_set = false
      @algorithm = nil
    end

    def id
      @id ||= 0
    end

    def algorithm_set
      @algorithm_set ||= false
    end
    
    def set_algorithm algorithm
      @algorithm_set = true
      @algorithm = algorithm
    end

    def increment_id
      @id = @id + 1
    end

  end

  def initialize opts={}
    raise ArgumentError, "trader must be initialized with trader list" unless opts[:trader_list].is_a? TraderList
    set_algorithm(opts[:algorithm]) unless self.class.algorithm_set
    @id = self.class.id
    self.class.increment_id
    @trader_list = opts[:trader_list]
    @trader_list.traders << self
    @partners = []
    add_partner opts[:partner] if opts[:partner]
    @token_store = []
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

  def pass_token partner, token
    partner.take_token token
  end

  def public_tokens
    @token_store
  end

  def take_token token
    @token_store << token
  end

  def step
    trading_step
  end

  private

  def set_algorithm algorithm
    algorithm ||= :basic_algorithm
    algorithm = Factory.constantize(algorithm)
    self.class.include algorithm
    self.class.set_algorithm algorithm
  end

end
