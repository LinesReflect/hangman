class Game
  attr_accessor :user

  def initialize(mode=choose_role)
    player_guesser if mode == '1'
    player_word_chooser if mode == '2'
    start_game
  end

  def choose_role
    puts "Enter the appropriate number for the role you want to play as."
    puts '1: Guesser 2: Word chooser'
    gets.chomp
  end

  def player_guesser
    @guesser = Player.new('Guesser')
    @word_chooser = Computer.new('Word chooser')
  end

  def player_word_chooser
    @word_chooser = Player.new('Word chooser')
    @guesser = Computer.new('Guesser')
  end
end
