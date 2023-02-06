require_relative 'game'
require_relative 'player'
require_relative 'computer'
require 'open-uri'

download = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')
IO.copy_stream(download, '../10000-words.txt')

def start_game
  Game.new.choose_role
  play_again
end

def play_again
  puts "Would you like to play again? Y/N"
  answer = gets.chomp
  if ['Y', 'y', 'N', 'n'].include?(answer)
    ['Y', 'y'].include?(answer) ? start_game : return
  else
    play_again
  end
end

puts 'Hello user, welcome to Hangman!'

start_game
