require_relative "item"
require_relative "bolts"
require_relative "weapon"
require_relative "laser"
require_relative "plasmaCannon"

class Robot
    attr_reader :position
    def initialize
        @position = [0,0]
    end


end

class Item
end

class Bolts
end

class Weapon
end

class Laser
end

class PlasmaCannon
end