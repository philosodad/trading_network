require_relative 'trader.rb'

class Miner < Trader
  class << self
    attr_reader :mining_algorithm_set, :mining_algorithm
    def reset
      super
      @mining_algorithm_set = false
      @mining_algoritm = nil
    end

    def set_mining_algorithm algorithm
      @mining_algorithm_set = true
      @mining_algorithm = algorithm
    end
  end

  def initialize opts={}
    super
    set_mining_algorithm(opts[:mining_algorithm]) unless self.class.mining_algorithm_set
  end

  def step
    mining_step
    super
  end

  private

  def set_mining_algorithm algorithm
    algorithm ||= :basic_mining_algorithm
    algorithm = Factory.constantize(algorithm)
    self.class.include algorithm
    self.class.set_mining_algorithm algorithm
  end
end
