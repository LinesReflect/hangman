require_relative 'game'
require_relative 'player'
require_relative 'computer'
require_relative 'word_chooser'
require_relative 'guesser'
require 'json'

module LoadGame
  def load_game(file_number)
    json_file = File.open("./saved_games/#{@saved_games_arr[file_number.to_i - 1]}")
    data = json_file.read
    Game.new.import_data(JSON.parse(data))
  end

  def list_saved_games
    Dir.chdir('..') unless Dir.pwd == "hangman"
    @saved_games_arr = []
    Dir.each_child('saved_games') { |filename| @saved_games_arr.push(filename) }
    @saved_games_arr.each_with_index { |filename, idx| puts "#{idx + 1}: '#{filename.chomp('.json')}'" }
    choose_saved_game(@saved_games_arr)
  end

  def choose_saved_game(saved_games_arr)
    puts 'Enter the appropriate number for the save file you wish to load.'
    file_number = gets.chomp
    valid_file_number?(file_number, saved_games_arr) ? load_game(file_number) : [puts('Not valid!'), choose_saved_game(saved_games_arr)]
  end

  def valid_file_number?(file_number, saved_games_arr)
    file_number.chars.all? { |char| (1..saved_games_arr.length).include?(char.to_i) }
  end
end