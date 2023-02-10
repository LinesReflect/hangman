require_relative 'load_game'
require_relative 'save_game'
require_relative 'guesser'
require 'json'

class Game
  include LoadGame
  include SaveGame

  attr_accessor :name, :guesser, :word_chooser, :word, :word_arr

  def choose_role
    puts "Enter the appropriate number for the role you want to play as."
    puts '1: Guesser 2: Word chooser'
    @mode = gets.chomp
    player_guesser if @mode == '1'
    player_word_chooser if @mode == '2'
    @wrong_guesses = 7
    run_game
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
    @word_arr = Array.new(@word.length, '_')
    update_display_info
    new_turn
  end

  def new_turn
    @guess = @guesser.guess_letter
    save_game if @guess == 'SAVE'
    correct_guess? ? correct_letter : wrong_letter unless @guess == 'SAVE'
    update_display_info
    winner? ? [clear_guesses, congratulate_winner] : new_turn
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
    puts 'Correct'
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

  def congratulate_winner
    puts "The word was #{@word}."
    zero_guesses? ? puts('Word Chooser wins! Congrats!') : puts('Guesser wins! Congrats!')
  end

  def clear_guesses
    @guesser.guessed_letters.clear
  end

  def end_game
    return
  end

  def import_data(data)
    @name = data.values[1]
    @mode = data.values[2]
    @guesser = data.values[3]
    @word_chooser = data.values[4]
    @word = data.values[5]
    @word_arr = data.values[6]
    @wrong_guesses = data.values[8]
    continue_game
  end

  def continue_game
    player_guesser if @mode == '1'
    player_word_chooser if @mode == '2'
    update_display_info
    new_turn
  end
end
