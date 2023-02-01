class Game
  attr_accessor :user

  def initialize(mode=choose_role)
    player_guesser if mode == '1'
    player_word_chooser if mode == '2'
    run_game
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

  def run_game
    @word = @word_chooser.choose_word
    @guess = @guesser.guess_letter
    puts @guess
  end
end
