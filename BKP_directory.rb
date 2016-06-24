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

#Solution to 8.5
def input_students_more
    add_more = ''
    #creates an empty array
    students = []
    
    puts "Adding more input options for list\n\n"
    until add_more == 'N' do
        puts "Please enter the name of a student"
        name = gets.chomp
        name = name.split.map(&:capitalize).join(' ')
        puts "Please enter the student's cohort"
        cohort = gets.chomp
        cohort = cohort.capitalize
        puts "Please enter student's country of birth"
        country = gets.chomp
        country = country.split.map(&:capitalize).join(' ')
        puts "Please enter student's height in cm."
        height = gets.chomp
        
        #add the student hash to the array
        students << {name: name, 
                     cohort: cohort,
                     country: country,
                     height: height}
        
        puts "Now we have #{students.count} students"
        
        add_more = ''
        
        until (add_more == 'Y') || (add_more == 'N') do
            puts "Add more students? (Y/N)"
            add_more = gets.chomp
            add_more = add_more.upcase!
        end
    end
    #return the array of students
    students
end

#Solution to 8.6
def align(students)
    longest_name = 0
    
    diff = 0
    puts "Showing pretty formatting using .center:\n"
    
    students.each do |student|
        if student[:name].length > longest_name
            longest_name = student[:name].length
        end
    end
    
    students.each_with_index do |student, index|
        index += 1
        diff = longest_name - student[:name].length
        puts "#{index.to_s.center(4)}: #{student[:name].to_s.center(longest_name, " ")} (#{student[:cohort].to_s.center(9, " ")} cohort)"
    end
end

#Solution to 8.3
def name_length(students, length)
    puts "Showing students whose name is less than #{length} characters long:\n"
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
    puts "Filtering list by letter: #{letter}\n"
    if letter =~ /[A-Z]/
        students.each_with_index do |student, index|
            if student[:name][0,1].upcase == letter
                puts "#{index+1}: #{student[:name]}: (#{student[:cohort]}: cohort)"
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
    puts "Showing index of list using .each_with_index:\n"
    students.each_with_index do |student, index|
        puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
    end
end

#Solution to 8.4
def print_while(students)
    student = 0
    puts "Printing list using while loop instead of .each:\n"
    while student < students.length do
        puts "#{student+1}: #{students[student][:name]} (#{students[student][:cohort]} cohort)"
        student += 1
    end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

#nothing happens until we call the methods
puts "8.5 demo"
students = input_students_more
puts students
=begin
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
puts "\n8.6 demo"
align(students)
=end