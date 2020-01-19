require_relative "item"
require_relative "bolts"
require_relative "weapon"
require_relative "laser"
require_relative "plasmaCannon"

class Robot
    attr_reader :position, :items, :health, :equipped_weapon
    def initialize
        @position = [0,0]
        @items = []
        @health = 100
        @equipped_weapon = nil
    end

    def equipped_weapon=(weapon)
        @equipped_weapon = weapon
    end

    def attack(other_robot)
        if @equipped_weapon == nil
            other_robot.wound(5)
        else
            @equipped_weapon.hit(other_robot)
        end
    end

    def heal(amount)
        @health + amount < 100 ? @health += amount : @health = 100
    end

    def wound(amount)
        amount < @health ? @health -= amount : @health = 0
    end

    def items_weight
        @items.length == 0 ? 0 : @items.sum {|item|item.weight}
    end

    def pick_up(item)
        if (items_weight + item.weight) > 250
            raise ArgumentError, "cannot add items past maximum weight of 250"
        end
        @items << item 
    end

    def move_left
        @position[0] -= 1
    end

    def move_right
        @position[0] += 1
    end

    def move_up
        @position[1] += 1
    end

    def move_down
        @position[1] -= 1
    end
end