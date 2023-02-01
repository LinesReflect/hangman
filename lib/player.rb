require_relative 'guesser'
require_relative 'word_chooser'

class Player
  include Guesser
  include WordChooser
  attr_accessor :role

  def initialize(role)
    @role = role
  end
end
