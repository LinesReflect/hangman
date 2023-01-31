require_relative 'game'
require_relative 'player'
require_relative 'computer'

def greeting
  puts 'Hello and welcome to Hangman user!'
  Game.new
end

greeting
