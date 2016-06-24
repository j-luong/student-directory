require 'io/console'

students = [
  {name: "Dr. Hannibal Lecter", cohort: :July, country: "United Kingdom", height: 150},
  {name: "Darth Vader", cohort: :July, country: "United Kingdom", height: 178},
  {name: "Nurse Ratched", cohort: :November, country: "France", height: 177},
  {name: "Michael Corleone", cohort: :November, country: "France", height: 184},
  {name: "Alex DeLarge", cohort: :January, country: "Germany", height: 210},
  {name: "The Wicked Witch of the West", cohort: :February, country: "Germany", height: 185},
  {name: "Terminator", cohort: :August, country: "Spain", height: 202},
  {name: "Freddy Krueger", cohort: :August, country: "Spain", height: 140},
  {name: "The Joker", cohort: :October, country: "United States", height: 158},
  {name: "Joffrey Baratheon", cohort: :September, country: "United States", height: 169},  
  {name: "Norman Bates", cohort: :September, country: "Sweden", height: 172}
]



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

def filter_students(students)
    puts "Enter a letter from A-Z"
    
    #taking the first character the user inputs only
    letter = STDIN.getch
    letter = letter.upcase
    
    if letter =~ /[A-Z]/
        students.each_with_index do |student, index|
            if student[:name][0,1].upcase == letter
                puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
            end
        end
    else
        puts "invalid"
    end
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
    
    puts ":#{headers[:id].center(4)}: #{headers[:name].center(longest_name," ")}: #{headers[:cohort].center(9," ")}: #{headers[:country].center(longest_country," ")}: #{headers[:height].center(3," ")}:"
    students.each_with_index do |student, index|
        index += 1
        puts ":#{index.to_s.center(4)}: #{student[:name].to_s.center(longest_name, " ")}: #{student[:cohort].to_s.center(9, " ")}: #{student[:country].to_s.center(longest_country, " ")}: #{student[:height].to_s.center(headers[:height].length, " ")}:"
    end
end

#align(students)

puts "press a key"
key = gets.chop
puts "You pressed #{key}, hello!"