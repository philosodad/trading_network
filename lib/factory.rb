class Factory
  class << self
    def create type, opts={}
      klass = constantize(type)
      klass.new(opts)
    end
    def constantize type
      const_get(type.to_s.split("_").map(&:capitalize).join.to_sym)
    end
  end
end
