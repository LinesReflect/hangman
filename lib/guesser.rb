module Guesser
  @@guessed_letters = []

  def guess_letter
    puts "Guess a letter or type 'SAVE' to save this game."
    guess = gets.chomp
    if valid_guess?(guess)
      @@guessed_letters.push(guess) unless guess == 'SAVE'
      guess
    else
      puts 'Not valid!'
      guess_letter
    end
  end

  def valid_length?(guess)
    guess.length == 1
  end

  def valid_charachter?(guess)
    guess.chars.all? { |char| ('a'..'z').include?(char.downcase) }
  end

  def valid_letter?(guess)
    @@guessed_letters.include?(guess)
  end

  def valid_guess?(guess)
    guess == 'SAVE' || (valid_length?(guess) && valid_charachter?(guess) && !@@guessed_letters.include?(guess))
  end

  def guessed_letters
    @@guessed_letters
  end
end
