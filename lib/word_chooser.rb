module WordChooser

  def choose_word
    puts "Enter a word between 5 and 12 letters long."
    word = gets.chomp.to_s
    if (word.length - 1).between?(5, 12) && word.chars.all? { |char| ('a'..'z').include?(char.downcase) }
      word
    else
      puts 'Not valid!!!'
      choose_word
    end
  end
end