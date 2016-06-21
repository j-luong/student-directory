require 'io/console'

students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},  
  {name: "Norman Bates", cohort: :november}
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

print_while(students)