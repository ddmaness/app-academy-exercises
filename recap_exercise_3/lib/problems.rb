

def no_dupes?(arr)
    val_count = Hash.new(0)
    no_dupes_arr = []
    arr.each do |val|
        val_count[val] += 1
    end
    val_count.each do |k, v|
        if v == 1
            no_dupes_arr << k
        end
    end
    p no_dupes_arr
end

no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    no_consecutive_repeats = true
    (0...arr.length - 1).each do |idx|
        no_consecutive_repeats = false if arr[idx] == arr[idx+1]
    end
    p no_consecutive_repeats
end

no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    char_indices_hash = Hash.new() { |h, k| h[k] = [] }
    str.each_char.with_index do |char, idx|
        char_indices_hash[char].push(idx)
    end
    p char_indices_hash
end

char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    longest = ''
    current = ''
    str.each_char do |char|
        if current.length == 0 || char == current[-1]
            current += char
        else
            current = char
        end
        if current.length >= longest.length
            longest = current
        end
    end
    p longest
end

longest_streak('a')           # => 'a'
longest_streak('accccbbb')    # => 'cccc'
longest_streak('aaaxyyyyyzz') # => 'yyyyy
longest_streak('aaabbb')      # => 'bbb'
longest_streak('abc')         # => 'c'
longest_streak('aaabbbaa')

# returns a 2D array of the factor pairs of a number
def factor_pairs(num)
    pairs = []
    (2...num).each do |int|
        if num % int == 0
            pairs << [int, (num / int)]
        end 
    end
    pairs
end

#checks if a number is prime
def is_prime?(num)
    prime = true
    (2...num).each do |int|
        if num % int == 0
            prime = false
        end
    end
    prime
end

def bi_prime?(num)
    pairs = factor_pairs(num)
    pairs.each do |pair|
        return true if !pair.any? {|elem| !is_prime?(elem)}
    end
    false
end

# Examples
p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    alph = ('a'..'z').to_a
    cipher = message.split('').map!.with_index do |char, idx|
        alph_index = alph.index(char)
        key_index = idx % keys.length
        vigenere_index = (alph_index + keys[key_index]) % alph.length
        alph[vigenere_index]
    end
    p cipher.join('')
end

# Examples
vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
vigenere_cipher("zebra", [3, 0])            # => "ceerd"
vigenere_cipher("yawn", [5, 1])             # => "dbbo"
vigenere_cipher("zzzzzz", [5, 1])           
vigenere_cipher("aaaaaa", [5, 1])           


def vowel_rotate(str)
    vowels = 'aeiou'
    vowels_in_str = []
    str.each_char do |char|
        if vowels.include?(char)
            vowels_in_str << char if vowels.include?(char)
        end
    end
    vowels_in_str.rotate!(-1)
    rotated_vowel_str = str.split('').map do |char|
        if vowels.include?(char)
            vowels_in_str.shift
        else
            char
        end
    end
    p rotated_vowel_str.join('')
end

# Examples
vowel_rotate('computer')      # => "cempotur"
vowel_rotate('oranges')       # => "erongas"
vowel_rotate('headphones')    # => "heedphanos"
vowel_rotate('bootcamp')      # => "baotcomp"
vowel_rotate('awesome')       # => "ewasemo"

class String
    def select(&prc)
        if prc == nil
            return ''
        end
        arr = self.split('')
        arr.map! do |char|
            if prc.call(char)
                char
            end
        end
        return arr.join('')
    end

    def map!(&prc)
        mapped_str = ''
        self.each_char.with_index do |char, i|
            self[i] = prc.call(char, i)
        end
    end
end

# Examples
"app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
"HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
"HELLOworld".select          # => ""

# Examples
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"

def multiply(a, b)
    if a < 0 && !b.kind_of?(Array)
        b = -b
    end
    if a == 0
        return p 0
    end
    if a == 1 || a == -1
        if b.kind_of?(Array)
            return p b.sum
        else
            return p b
        end
    end
    if b.kind_of?(Array)
        if a > 0
            multiply(a - 1, b << b[-1])
        else
            multiply(a + 1, b << b[-1])
        end
    else
        if a > 0
            multiply(a-1, [b] << b)
        else
            multiply(a+1, [b] << b)
        end
    end
end

# Examples
multiply(3, 5)        # => 15
multiply(5, 3)        # => 15
multiply(2, 4)        # => 8
multiply(0, 10)       # => 0
multiply(-3, -6)      # => 18
multiply(3, -6)       # => -18
multiply(-3, 6)       # => -18

def lucas_sequence(length)
    if length == 0 
        return  []
    elsif length == 1 
        return  [2]
    elsif length == 2 
        return [2, 1]
    elsif length > 2
        return lucas_sequence(length - 1) << (lucas_sequence(length - 1)[-2] + lucas_sequence(length - 1)[-1])
    end
end

# Examples
lucas_sequence(0)   # => []
lucas_sequence(1)   # => [2]    
lucas_sequence(2)   # => [2, 1]
lucas_sequence(3)   # => [2, 1, 3]
lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]


def prime_factorization(num)
    (2...num).each do |int|
        if num % int == 0
            return [*prime_factorization(int), *prime_factorization(num / int)]     
        end
    end
    [ num ]
end

# Examples
p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]