require_relative "room"

class Hotel
  def initialize(name, hash)
    @name = name
    @rooms = Hash.new()
    hash.each do |k, v|
        @rooms[k] = Room.new(v)
    end
  end

  def name
      @name.split(' ').map {|word| word.capitalize}.join(' ')
  end

  def rooms
      @rooms
  end

  def room_exists?(name)
      return false if @rooms[name] == nil
      true
  end

  def check_in(person, room)
    if self.room_exists?(room)
        if @rooms[room].add_occupant(person)
            p 'check in successful'
        else
            p 'sorry, room is full'
        end
    else
        p 'sorry, room does not exist'
    end
  end

  def has_vacancy?
      @rooms.each_key do |k|
        if !@rooms[k].full?
          return true
        end
      end
      false
  end

  def list_rooms
        @rooms.each_key do |k|
            print k.chomp
            p @rooms[k].available_space
        end
  end
end
