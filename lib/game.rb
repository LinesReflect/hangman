class Game
  attr_accessor :user

  def initialize(mode=choose_role)
    player_guesser if mode == '1'
    player_word_chooser if mode == '2'
    @wrong_guesses = 7
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
    puts @word
    @word_arr = Array.new(@word.length, '_')
    new_turn
  end

  def new_turn
    @guess = @guesser.guess_letter
    correct_guess? ? correct_letter : wrong_letter
    update_display_info
    winner? ? puts('gg') : new_turn
  end

  def update_display_info
    puts "#{display_hangman} #{display_guesses} Wrong guesses left: #{@wrong_guesses}"
  end

  def display_hangman
    @word_arr.join(' ')
  end

  def display_guesses
    "Guessed letters: #{@guesser.guessed_letters}"
  end

  def correct_guess?
    @word.chars.any? { |char| char.downcase.include?(@guess) }
  end

  def correct_letter
    @word.chars.each_with_index { |char, idx| @word_arr[idx] = @guess if char.downcase == @guess}
    end_game if complete_word?
  end

  def complete_word?
    @word.chars == @word_arr
  end

  def wrong_letter
    puts 'Wrong'
    @wrong_guesses -= 1
  end

  def zero_guesses?
    @wrong_guesses.zero?
  end

  def winner?
    complete_word? || zero_guesses?
  end

  def end_game
    return
  end
end
