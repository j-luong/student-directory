require 'io/console'

def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    #creates an empty array
    students = []
    #gets the first name
    name = gets.chomp
    #while the name is not empty, repeat this code
    while !name.empty? do
        #add the student hash to the array
        students << {name: name, cohort: :november}
        puts "Now we have #{students.count} students"
        #get another name from the user
        name = gets.chomp
    end
    #return the array of students
    students
end

#Solution to 8.3
def name_length(students, length)
    students.each_with_index do |student, index|
        if student[:name].length < length
            puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
        end
    end
end

#Solution to 8.2
def filter_students(students)
    puts "Enter a letter from A-Z"
    
    #taking the first character the user inputs only (using: require 'io/console')
    letter = STDIN.getch
    letter = letter.upcase
  
    if letter =~ /[A-Z]/
        students.each_with_index do |student, index|
            if student[:name][0,1].upcase == letter
                puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
            end
        end
    else
        puts "Invalid input!"
    end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

#Solution to 8.1
def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#Solution to 8.4
def print_while(students)
    student = 0
    while student < students.length do
        puts "#{student+1}: #{students[student][:name]} (#{students[student][:cohort]} cohort)"
        student += 1
    end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

#nothing happens until we call the methods
students = input_students
puts "\n8.1 demo"
print_header
print(students)
print_footer(students)
puts "\n8.2 demo"
filter_students(students)
puts "\n8.3 demo"
name_length(students, 12)
puts "\n8.4 demo"
print_while(students)