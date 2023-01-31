require_relative 'game'
require_relative 'player'
require_relative 'computer'
require 'open-uri'

download = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')
IO.copy_stream(download, '../10000-words.txt')

def greeting
  puts 'Hello and welcome to Hangman user!'
  Game.new
end

greeting
