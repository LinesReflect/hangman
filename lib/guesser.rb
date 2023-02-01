module Guesser
  def guess_letter
    puts 'Guess a letter!'
    guess = gets.chomp
    valid_guess?(guess) ? guess : [puts('Not valid!'), guess_letter]
  end

  def valid_guess?(guess)
    guess.length == 1 && guess.chars.all? { |char| ('a'..'z').include?(char.downcase) }
  end
end