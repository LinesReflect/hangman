require_relative 'guesser'
require_relative 'word_chooser'

class Computer
  include Guesser
  include WordChooser
  attr_accessor :role

  def initialize(role)
    @role = role
  end

  def choose_word
    word_list = File.open('../10000-words.txt').each_line.collect do |line|
      line.downcase
    end
    @word = word_list.sample.gsub("\n", '')
    @word.length.between?(5, 12) ? @word : choose_word
  end

  def guess_letter
    puts 'Thinking...'
    sleep(2)
    @guess = (('a'..'z').to_a - guessed_letters).sample
    if valid_guess?(@guess)
      guessed_letters.push(@guess)
      @guess
    else
      puts 'Not valid!'
      guess_letter
    end
  end
end