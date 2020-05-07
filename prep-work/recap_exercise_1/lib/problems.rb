# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]

require 'byebug'

def all_vowel_pairs(words)
    pairs = []
    i = 0
    while i < words.length - 1 
        j = i + 1
        while j < words.length
            pairs << "#{words[i]} #{words[j]}" if word_pair_vowel_check(words[i], words[j])
            j += 1
        end
        i+=1
    end
    pairs
end

def word_pair_vowel_check(word1, word2)
    vowels = ['a', 'e', 'i', 'o' , 'u']
    vowel_check = {
        'a' => false,
        'e' => false,
        'i' => false,
        'o' => false,
        'u' => false,
    }
    vowels.each do |vowel|
        vowel_check[vowel] = true if word1.include?(vowel) || word2.include?(vowel)
    end
    vowel_check.values.all? {|bool| bool}
end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    (2..num).each_with_index do |val_1, idx_1|
        (2..num).each_with_index do |val_2, idx_2|
            return true if idx_2 >= idx_1 && val_1 * val_2 == num
        end
    end
    false
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    found_bigrams = []
    bigrams.each do |bigram|
        found_bigrams << bigram if str.include?(bigram)
    end
    found_bigrams
end


class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        prc ||= Proc.new { |k, v| k == v}
        new_hash = {}
        self.each do |k, v|
            new_hash[k] = v if prc.call(k, v)
        end
        new_hash
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        substring_arr = []
        if length
            self.each_char.with_index do |char, idx|
                if idx <= self.length - length
                    substring_arr << self[idx, length]
                end
            end
        else
            self.each_char.with_index do |char_1, idx_1|
                self.each_char.with_index do |char_2, idx_2|
                    substring_arr << self[idx_1..idx_2] if idx_2 >= idx_1
                end
            end
        end
        substring_arr
    end


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)
        alph = ('a'..'z').to_a
        cipher = self.split('').map do |char|
            idx = alph.index(char)
            cipher_idx = (idx + num) % alph.length
            alph[cipher_idx]
        end
        cipher.join('')
    end
end
