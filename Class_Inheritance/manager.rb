require_relative "employee"
class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss, employees)
        super(name, title, salary, boss)
        @employees = employees
    end

    def bonus(multiplier)
        @bonus = total_sal_sub_emps * multiplier
    end

    def total_sal_sub_emps
        total = 0
        @employees.each do |employee|
            total += employee.total_sal_sub_emps if employee.is_a?(Manager)
            total += employee.salary
        end
        total
    end
end

# puts "test_cases: "

# david = Employee.new("David", "TA", 10000, "Darren")
# shawna = Employee.new("Shawna", "TA", 12000, "Darren")

# darrens_employees = [shawna, david]
# darren = Manager.new("Darren", "TA Manager", 78000, "Ned", darrens_employees)

# neds_employees = [darren]
# ned = Manager.new("Ned", "Founder", 1000000, nil, neds_employees)

# puts ned.bonus(5) # => 500_000
# puts darren.bonus(4) # => 88_000
# puts david.bonus(3) # => 30_000