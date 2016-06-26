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

def interactive_menu
    students = []
    loop do
        
        # 1. print the menu and ask the user what to do
        puts "1. Input the students"
        puts "2. Show the students"
        puts "9. Exit" # 9 because we'll be adding more items
        
        # 2. read the input and save it into a variable
        selection = gets.chomp
        
        # 3. do what the user has asked
        case selection
        when "1"
            students = input_students(students)
        when "2"
            print_students(students)
        when "9"
            exit # this will cause the program to terminate
        else
            puts "I don't know what you meant, try again"
        end
    end
end

#Solution to 8.5/8.7/8.9
def input_students(students)
    add_more = ''

    until add_more == 'N' do
        name = ''
        while name.empty? do
            puts "Please enter the name of a student"
            name = gets.chomp
            name = name.split.map(&:capitalize).join(' ') #capitalize each word of the string
        end
        
        cohort = 0
        until cohort.to_i.between?(1,12) do
            puts "Please enter the student's cohort between 1-12 (1 = January - 12 = December"
            cohort = gets.chomp
        end
        
        country = ''
        while country.empty? do
            puts "Please enter student's country of birth"
            country = gets.chomp
            country = country.split.map(&:capitalize).join(' ') #capitalize each word of the string
        end
        
        height = 0
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

#Solution to 8.1, 8.4, 8.6, 8.8, 8.12
def print_students(students)
    #Making sure there are students in the list
    if students.empty?
        puts "There are no students!"
        return
    end
    
    longest_name = 0
    longest_country = 0
    headers = {id: "ID", name: "Name", cohort: "Cohort", country: "Country", height: "Height"}
    
    #Getting the longest name and country so we know how much spacing to use with pretty formatting
    students.each do |student|
        if student[:name].length > longest_name
            longest_name = student[:name].length
        end
        if student[:country].length > longest_country
            longest_country = student[:country].length
        end
    end
    
    #8.8 solution, sorting list by cohort
    students = students.sort_by {|value| value[:cohort].to_i}
    
    print_header
    
    puts ": #{headers[:id].center(4)} : #{headers[:name].center(longest_name," ")} : #{headers[:cohort].center(9," ")} : #{headers[:country].center(longest_country," ")} : #{headers[:height].center(3," ")} :"
    
    #8.1 solution, using .each_with_index
    students.each_with_index do |student, index|
        index += 1
        #8.6 solution, using .center for pretty formatting
        puts ": #{index.to_s.center(4)} : #{student[:name].to_s.center(longest_name, " ")} : #{Date::MONTHNAMES[student[:cohort].to_i].to_s.center(9, " ")} : #{student[:country].to_s.center((longest_country > 8 ? longest_country:7) , " ")} : #{student[:height].to_s.center(headers[:height].length, " ")} :"
    end
    print_footer(students)
end

#Solution to 8.3
def name_length(students, length)
    filtered_list = []
    puts "Showing students whose name is less than #{length} characters long:\n"
    
    filtered_list = students.select { |value| value[:name].length < length }
    
    print_students(filtered_list)
end

#Solution to 8.2
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
    puts " " * 35 + "The students of Villains Academy"
    puts "-" * 100
end

def print_footer(names)
    if names.empty?
        puts
    elsif names.count == 1
        puts "Overall, we have #{names.count} great student"
    else
        puts "Overall, we have #{names.count} great students"
    end
end

#nothing happens until we call the methods
# students = input_students(students)
#print_students(students)
# filter_students(students)
# name_length(students, 12)
# print_while(students)
# print_students(students)
# order_students(students)

interactive_menu
