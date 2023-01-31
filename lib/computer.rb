require_relative 'word_chooser'

class Computer
  include WordChooser
  attr_accessor :role

  def initialize(role)
    @role = role
  end

  def choose_word
    word_list = File.open('../10000-words.txt').each_line.collect do |line|
      line.downcase
    end
    word = word_list.sample
    (word.length - 1).between?(5, 12) ? word : choose_word
  end
end