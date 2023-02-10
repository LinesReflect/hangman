require_relative 'game'
require_relative 'player'
require_relative 'computer'
require_relative 'word_chooser'
require_relative 'guesser'
require 'json'

module LoadGame
  def load_game(file_number)
    json_file = File.read("../saved_games/#{@saved_games_arr[file_number.to_i - 1]}")
    Game.new.import_data(JSON.parse(json_file))
  end

  def list_saved_games
    if Dir.exist?('../saved_games')
      @saved_games_arr = []
      Dir.each_child('../saved_games') { |filename| @saved_games_arr.push(filename) }
      @saved_games_arr.each_with_index { |filename, idx| puts "#{idx + 1}: '#{filename.chomp('.json')}'" }
      no_saves? ? starting_new_game : choose_saved_game(@saved_games_arr)
    else
      starting_new_game
    end
  end

  def choose_saved_game(saved_games_arr)
    puts 'Enter the appropriate number for the save file you wish to load.'
    file_number = gets.chomp
    valid_file_number?(file_number, saved_games_arr) ? load_game(file_number) : [puts('Not valid!'), choose_saved_game(saved_games_arr)]
  end

  def valid_file_number?(file_number, saved_games_arr)
    file_number.chars.all? { |char| (1..saved_games_arr.length).include?(char.to_i) }
  end

  def no_saves?
    @saved_games_arr.length.zero?
  end

  def starting_new_game
    puts 'Looks like there are no saved games. Lets start a new one!'
    Game.new.choose_role
  end
end