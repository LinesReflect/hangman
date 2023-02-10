require_relative 'player'
require_relative 'computer'
require_relative 'word_chooser'
require_relative 'guesser'
require 'json'

module SaveGame
  attr_accessor :name, :guesser, :word_chooser, :word, :word_arr

  def save_data
    @data = {
      game: self,
      save_name: @name,
      mode: @mode,
      guesser: @guesser,
      chooser: @word_chooser,
      word: @word,
      word_arr: @word_arr,
      guessed_letters: @guesser.guessed_letters,
      wrong_guesses: @wrong_guesses
    }
  end

  def game_data
    @data.to_json
  end

  def save_game
    puts 'Enter a title to save you game as.'
    @name = gets.chomp
    save_data
    save_game_file(game_data)
    puts 'Succesfully Saved!'
  end

  def save_game_file(game_data)
    Dir.chdir("..")
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    Dir.chdir('saved_games')
    filename = "#{sort_data}.json"
    File.open(filename, 'w') do |file|
      file.puts game_data
    end
    Dir.chdir("../lib")
  end

  def sort_data
    @data[:save_name]
  end
end