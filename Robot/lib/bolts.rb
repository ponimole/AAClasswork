require_relative "item"
class Bolts < Item
    def initialize
        super("bolts",25)
    end

    def feed(robot)
        robot.heal(25)
    end
end

