require 'io/console'
require 'date'

#Solution to 8.5/8.7
def input_students
    add_more = ''
    #creates an empty array
    students = []
    
    puts "Adding more input options for list (8.5), cohort is no longer hard coded (8.7).\n\n"
    until add_more == 'N' do
        name = ''
        while name.empty? do
            puts "Please enter the name of a student"
            name = gets.chomp
            name = name.split.map(&:capitalize).join(' ')
        end
        
        cohort = 0
        until cohort.to_i.between?(1,12) do
            puts "Please enter the student's cohort between 1-12 (1 = January - 12 = December"
            cohort = gets.chomp
        end
        
        cohort = Date::MONTHNAMES[cohort.to_i]
        cohort = cohort.to_sym
        
        country = ''
        while country.empty? do
            puts "Please enter student's country of birth"
            country = gets.chomp
            country = country.split.map(&:capitalize).join(' ')
        end
        
        height = ''
        until (height.to_i >= 50) && (height.to_i <= 300) do
            puts "Please enter student's height in (between 50cm - 300cm.)"
            height = gets.chomp
        end
        #add the student hash to the array
        students << {name: name, 
                     cohort: cohort,
                     country: country,
                     height: height}
        
        if students.length == 1
            puts "Now we have #{students.count} student"
        else
            puts "Now we have #{students.count} students"
        end
        
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
    longest_country = 0
    headers = {id: "ID", name: "Name", cohort: "Cohort", country: "Country", height: "Height"}
    
    puts "Showing pretty formatting using .center:\n"
    
    students.each do |student|
        if student[:name].length > longest_name
            longest_name = student[:name].length
        end
        if student[:country].length > longest_country
            longest_country = student[:country].length
        end
    end
    
    puts ": #{headers[:id].center(4)} : #{headers[:name].center(longest_name," ")} : #{headers[:cohort].center(9," ")} : #{headers[:country].center(longest_country," ")} : #{headers[:height].center(3," ")} :"
    students.each_with_index do |student, index|
        index += 1
        puts ": #{index.to_s.center(4)} : #{student[:name].to_s.center(longest_name, " ")} : #{student[:cohort].to_s.center(9, " ")} : #{student[:country].to_s.center((longest_country > 8 ? longest_country:7) , " ")} : #{student[:height].to_s.center(headers[:height].length, " ")} :"
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

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

#nothing happens until we call the methods
puts "8.5 demo"
students = input_students
align(students)
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