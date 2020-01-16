class Employee
    attr_reader :name, :title, :salary, :boss

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end
end

class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss, employees)
        super
        @employees = employees
    end
end