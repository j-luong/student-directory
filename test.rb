require 'io/console'
require 'date'
require 'csv'

# Global variable definitions
@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to .csv file"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items  
end

def interactive_menu
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end
end

def process(selection)
    case selection
    when "1"
        puts "You've chosen to input students."
        input_students
    when "2"
        puts "You've chosen to display the list of students."
        show_students
    when "3"
        puts "You've chosen to save the list of students."
        save_students
    when "4"
        puts "You've chosen to load a saved list of students."
        load_students
    when "9"
        exit
    else
        puts "I don't know what you mean, try again!"
    end
end

# Solution to 8.5/8.7/8.9
def input_students
    add_more = ''

    until add_more == 'N' do
        name = ''
        while name.empty? do
            puts "Please enter the name of a student"
            name = STDIN.gets.chomp
            name = name.split.map(&:capitalize).join(' ') #capitalize each word of the string
        end
        
        cohort = 0
        until cohort.to_i.between?(1,12) do
            puts "Please enter the student's cohort between 1-12 (1 = January - 12 = December"
            cohort = STDIN.gets.chomp
        end
        
        country = ''
        while country.empty? do
            puts "Please enter student's country of birth"
            country = STDIN.gets.chomp
            country = country.split.map(&:capitalize).join(' ') #capitalize each word of the string
        end
        
        height = 0
        until (height.to_i >= 50) && (height.to_i <= 300) do
            puts "Please enter student's height in (between 50cm - 300cm.)"
            height = STDIN.gets.chomp
        end
        
        # Add the student hash to the array
        # @students << {name: name, 
        #               cohort: cohort,
        #               country: country,
        #               height: height}
        add_students(name, cohort, country, height)
        
        if @students.length == 1
            puts "Now we have #{@students.count} student"
        else
            puts "Now we have #{@students.count} students"
        end
        
        add_more = ''
        until (add_more == 'Y') || (add_more == 'N') do
            puts "Add more students? (Y/N)"
            add_more = STDIN.gets.chomp
            add_more = add_more.upcase!
        end
    end
end

def show_students
    print_header
    print_students
    print_footer
end

def print_header
    puts " " * 35 + "The students of Villains Academy"
    puts "-" * 100
end

# Creating method to add students to array, 14.1 solution
def add_students(name, cohort, country, height)
    @students << {name: name, 
                  cohort: cohort, 
                  country: country, 
                  height: height}
end

# Solution to 8.1, 8.4, 8.6, 8.8, 8.12
def print_students
    # Making sure there are students in the list
    if @students.empty?
        puts "There are no students!"
        return
    end
    
    longest_name = 0
    longest_country = 0
    headers = {id: "ID", name: "Name", cohort: "Cohort", country: "Country", height: "Height"}
    
    # Getting the longest name and country so we know how much spacing to use with pretty formatting
    @students.each do |student|
        if student[:name].length > longest_name
            longest_name = student[:name].length
        end
        if student[:country].length > longest_country
            longest_country = student[:country].length
        end
    end
    
    # 8.8 solution, sorting list by cohort
    @students = @students.sort_by {|value| value[:cohort].to_i}
    
    puts ": #{headers[:id].center(4)} : #{headers[:name].center(longest_name," ")} : #{headers[:cohort].center(9," ")} : #{headers[:country].center(longest_country," ")} : #{headers[:height].center(3," ")} :"
    
    # 8.1 solution, using .each_with_index
    @students.each_with_index do |student, index|
        index += 1
        # 8.6 solution, using .center for pretty formatting
        puts ": #{index.to_s.center(4)} : #{student[:name].to_s.center(longest_name, " ")} : #{Date::MONTHNAMES[student[:cohort].to_i].to_s.center(9, " ")} : #{student[:country].to_s.center((longest_country > 8 ? longest_country:7) , " ")} : #{student[:height].to_s.center(headers[:height].length, " ")} :"
    end
end

def print_footer
    if @students.empty?
        puts
    elsif @students.count == 1
        puts "Overall, we have #{@students.count} great student"
    else
        puts "Overall, we have #{@students.count} great students"
    end
end

def save_students
    puts "Name your save file (file type will automatically be .csv):"
    name = STDIN.gets.chomp
    name += ".csv"
    
    # Open file for writing
    CSV.open name.to_s, 'w' do |file|
        # Iterate over the array of students
        @students.each do |student|
            # student_data = [student[:name], student[:cohort], student[:country], student[:height]]
            # csv_line = student_data.join(",")
            file << [student[:name], student[:cohort], student[:country], student[:height]]
        end
    end
end

def load_students(filename = show_saved_files)
    # When loading a file, the @students array should be cleared of all contents so that the contents
    # of the loaded file can be written to it
    @students = []
    CSV.foreach(filename.to_s, "r") do |file|
        name, cohort, country, height = file
        add_students(name, cohort, country, height)
    end
end

def show_saved_files
    choice = 0
    # Look for valid .csv files and store in array
    saved_files = Dir['*.csv']

    until (choice.to_i > 0) && (choice.to_i <= saved_files.count) do
        puts "Saved .csv files in current directory, press a corresponding number to load file:"
        
        saved_files.each_with_index do |file, index|
            index += 1
            puts "#{index} : #{file}"
        end
        choice = STDIN.gets.chomp
        choice = choice.to_i
    end
    puts "Loaded #{saved_files[(choice-1)]}"
    
    saved_files[(choice-1)]
end

def try_load_students
    filename = ARGV.first # first argument from cmomand line
    
    # Soltution to 14.2: Load "students.csv" by default if no arguments are given when script is run
    filename = "students.csv" if filename.nil? # exit method if there are no arguments given from command line
    
    if File.exists?(filename) # laod the file if it exists
        load_students(filename)
        puts "Loaded #{@students.count} from #{filename}"
    else
        puts "Sorry, #{filename} does not exist."
    end
end

try_load_students
interactive_menu
