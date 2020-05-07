require "byebug"
# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    if self.length > 0
      smallest = self.reduce do |a, el|
        if a > el
          el
        else
          a
        end
      end
      largest = self.reduce do |a, el|
        if a < el
          el
        else
          a
        end
      end
      largest - smallest
    else
      return nil
    end
  end
  
  def average
    if self.length > 0
      return self.reduce {|a, el| a + el} / (self.length * 1.0)
    else
      return nil
    end
  end

  def median
    if self.length > 0
      if self.length % 2 == 0
        (self.sort[(self.length / 2) - 1] + self.sort[self.length / 2]) / 2.0
      else
        self.sort[self.length / 2]
      end
    else
      return nil
    end
  end

  def counts
    count = Hash.new(0)
    self.each {|el| count[el] += 1}
    count
  end

  def my_count(val)
    count = 0
    self.each {|el| count += 1 if val == el}
    count    
  end

  def my_index(val)
    self.each_with_index do |el, i|
      return i if el == val 
    end
    return nil
  end
  def my_uniq
    uniques = []
    elements = Hash.new
    self.each {|el| elements[el] = 'found' }
    elements.each_key { |k| uniques << k }
    uniques
  end
  
  def my_transpose
    dimensions = self.length
    outer = []
    dimensions.times do
      outer << []
    end
    i = 0
    while i < dimensions
      j = 0
      while j < dimensions
        outer[i][j] = self[j][i]
        j += 1
      end
      i += 1
    end
    outer
  end
end
