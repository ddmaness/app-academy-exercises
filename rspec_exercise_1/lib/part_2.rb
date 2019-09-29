def hipsterfy(word)
    vowels = 'aeiou'
    i = word.length - 1
    while i >= 0
        if vowels.include?(word[i])
            word[i] = ''
            return word
        end
        i -= 1
    end
    word
end

def vowel_counts(str)
    vowels = 'aeiou'
    vowel_count = Hash.new(0)
    str.each_char do |l|
        if vowels.include?(l.downcase)
            vowel_count[l.downcase] += 1
        end
    end
    vowel_count
end

def caesar_cipher(message, n)
    alph_count = 26
    alph = 'abcdefghijklmnopqrstuvwxyz'
    message.each_char.with_index do |char, idx|
        if char.upcase != char.downcase
            message[idx] = alph[(alph.index(char) + n) % alph_count]
        end
    end
    message
endcd 