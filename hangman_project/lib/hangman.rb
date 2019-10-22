class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    return DICTIONARY.sample
  end
  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    return @guess_word
  end

  def attempted_chars
    return @attempted_chars
  end

  def remaining_incorrect_guesses
    return @remaining_incorrect_guesses    
  end

  def already_attempted?(char)
      return @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    matching_indices = []
    @secret_word.each_char.with_index do |l, idx|
      matching_indices << idx if l == char
    end
    return matching_indices
  end

  def fill_indices(char, arr)
    arr.each do |idx| 
      @guess_word[idx] = char
    end
  end

  def try_guess(char)
    attempted = self.already_attempted?(char)
    indices = self.get_matching_indices(char)
    self.fill_indices(char, indices)
    if indices.length < 1
      @remaining_incorrect_guesses -= 1
    end
    if attempted
      p 'that has already been attempted'
      return false
    else
      @attempted_chars << char
      return true
    end
  end

  def ask_user_for_guess
    p 'Enter a char:'
    response = gets.chomp
    result = self.try_guess(response)
    return result
  end

  def win?
    if @guess_word.join('') == @secret_word
      p 'WIN'
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p 'LOSE'
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      p @secret_word
      return true
    else
      return false
    end
  end
end
