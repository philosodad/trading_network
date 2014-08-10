class Token
  require 'securerandom'
  attr_reader :id
  def initialize
    @id = SecureRandom.uuid
  end
end
