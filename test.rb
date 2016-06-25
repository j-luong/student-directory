require 'io/console'
require 'date'

students = [
  {name: "Dr. Hannibal Lecter", cohort: 1, country: "United Kingdom", height: 150},
  {name: "Darth Vader", cohort: 3, country: "United Kingdom", height: 178},
  {name: "Nurse Ratched", cohort: 6, country: "France", height: 177},
  {name: "Michael Corleone", cohort: 2, country: "France", height: 184},
  {name: "Alex DeLarge", cohort: 9, country: "Germany", height: 210},
  {name: "The Wicked Witch of the West", cohort: 10, country: "Germany", height: 185},
  {name: "Terminator", cohort: 9, country: "Spain", height: 202},
  {name: "Freddy Krueger", cohort: 11, country: "Spain", height: 140},
  {name: "The Joker", cohort: 11, country: "United States", height: 158},
  {name: "Joffrey Baratheon", cohort: 8, country: "United States", height: 169},  
  {name: "Norman Bates", cohort: 4, country: "Sweden", height: 172}
]

=begin
def print(students)
    puts "Enter a letter from A-Z"
    
    #taking the first character the user inputs only
    letter = STDIN.getch
    letter = letter.downcase
    
    if 
        print "OK!"
    else
        print "Invalid character!"
    end
    
    students.each_with_index do |student, index|
        puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
    end
end
=end

def filter_students(students)
    filtered_list = []
    
    puts "Enter a letter from A-Z"
    #taking the first character the user inputs only (using: require 'io/console')
    letter = STDIN.getch
    letter = letter.upcase
    
    until letter =~ /[A-Z]/ do
        if letter !=~/[A-|]/
            puts "Invalid input!"
        end
        
        letter = STDIN.getch
        letter = letter.upcase
    end
            
    puts "Filtering list by letter: #{letter}\n"
    filtered_list = students.select { |value| value[:name][0,1] == letter }

    print_students(filtered_list)
end

def name_length(students, length)
    students.each_with_index do |student, index|
        if student[:name].length < length
            puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
        end
    end
end

def print_while(students)
    student = 0
    while student < students.length do
        puts "#{student+1}: #{students[student][:name]} (#{students[student][:cohort]} cohort)"
        student += 1
    end
end

def input_students_more
    add_more = ''
    #creates an empty array
    students = []

    until add_more == 'N' do
        puts "Please enter the name of a student"
        name = gets.chomp
        name = name.capitalize
        puts "Please enter the student's cohort"
        cohort = gets.chomp
        cohort = cohort.capitalize
        puts "Please enter student's country of birth"
        country = gets.chomp
        country = country.capitalize
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

def align(students)
    longest_name = 0
    longest_country = 0
    headers = {id: "ID", name: "Name", cohort: "Cohort", country: "Country", height: "Height"}
    
    students.each do |student|
        if student[:name].length > longest_name
            longest_name = student[:name].length
        end
        if student[:country].length > longest_country
            longest_country = student[:country].length
        end
    end
    
    #students = students.sort_by {|value| value[:cohort]}
    
    puts ":#{headers[:id].center(4)}: #{headers[:name].center(longest_name," ")}: #{headers[:cohort].center(9," ")}: #{headers[:country].center(longest_country," ")}: #{headers[:height].center(3," ")}:"
    students.each_with_index do |student, index|
        index += 1
        puts ":#{index.to_s.center(4)}: #{student[:name].to_s.center(longest_name, " ")}: #{student[:cohort].to_s.center(9, " ")}: #{student[:country].to_s.center((longest_country > 8 ? longest_country:7) , " ")}: #{student[:height].to_s.center(headers[:height].length, " ")}:"
    end
end

def order_students(students)
    month = 0
    until month.to_i.between?(1,12) do
        puts "Please enter the student's cohort between 1-12 (1 = January - 12 = December"
        month = gets.chomp
    end
        
    month = Date::MONTHNAMES[month.to_i]
    month = month.to_sym

    students_select = students.select { |value| value[:cohort] == month }
    
    if students_select.length == 0
        puts "No students in the #{month} cohort."
    else
        puts "Showing students in the #{month} cohort:"
        align(students_select)
    end
end

def print_students(students)
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
    
    students = students.sort_by {|value| value[:cohort]}
    
    puts ": #{headers[:id].center(4)} : #{headers[:name].center(longest_name," ")} : #{headers[:cohort].center(9," ")} : #{headers[:country].center(longest_country," ")} : #{headers[:height].center(3," ")} :"
    students.each_with_index do |student, index|
        index += 1
        puts ": #{index.to_s.center(4)} : #{student[:name].to_s.center(longest_name, " ")} : #{Date::MONTHNAMES[student[:cohort]].to_s.center(9, " ")} : #{student[:country].to_s.center((longest_country > 8 ? longest_country:7) , " ")} : #{student[:height].to_s.center(headers[:height].length, " ")} :"
    end
end

filter_students(students)