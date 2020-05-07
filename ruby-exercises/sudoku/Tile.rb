require 'colorize'

class Tile
    def initialize(value, given = false)
        @value = value
        @given ||= given
    end

    def to_s
        "#{@value} ".colorize(self.display_color)
    end

    def display_color
        if self.is_given?
            return :light_blue
        else
            return :light_yellow
        end
    end

    def is_given?
        @given
    end

    def value
        @value
    end

    def set_value(value)
        if self.is_given?
            p "please pick a valid tile"
        else
            @value = value  
        end
    end

    def ==(tile)
        self.value == tile.value
    end

    def <(tile)
        self.value < tile.value
    end

    def <=(tile)
        self.value <= tile.value
    end

    def >(tile)
        self.value > tile.value
    end

    def >=(tile)
        self.value >= tile.value
    end
end
