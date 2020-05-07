
class Card
    def initialize(face_value)
        @face_value = face_value
        @face_up = false
    end

    def face_value
        @face_value
    end

    def face_up
        @face_up
    end

    def display_value
        @face_value if @face_up
    end

    def reveal
        @face_up = true
        self.display_value
    end
    
    def hide
        @face_up = false
    end

    def ==(card)
        self.face_value == card.face_value
    end
end
