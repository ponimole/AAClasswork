class Employee
    attr_reader :name, :title, :salary, :boss, :bonus

    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        @bonus = nil
    end

    def bonus(multiplier)
        @bonus = salary * multiplier
    end
end