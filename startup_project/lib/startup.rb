require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        salaries[title] != nil
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(name, title)
        if self.valid_title?(title)
            @employees << Employee.new(name, title)
        else
            raise 'Could not hire this employee'
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        pay_amount = @salaries[employee.title]
        if @funding >= pay_amount
            employee.pay(pay_amount)
            @funding -= pay_amount
        else
            raise 'You do not have enough funding to pay this employee'
        end
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        total_payout = 0
        @employees.each do |employee| 
            total_payout += @salaries[employee.title]
        end
        total_payout / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.employees.each {|employee| @employees << employee}
        startup.salaries.each do |k, v| 
            @salaries[k] = v if @salaries[k] == nil
        end
        startup.close
    end
end
