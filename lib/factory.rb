class Factory
  class << self
    def create type, opts={}
      klass = constantize(type)
      if klass.instance_method(:initialize).parameters.empty?
        klass.new
      else
        klass.new(opts)
      end
    end
    def constantize type
      const_get(type.to_s.split("_").map(&:capitalize).join.to_sym)
    end
  end
end
