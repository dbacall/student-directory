@students = []  

def input_students
  puts "Please enter the names of the students"
  puts "Which cohort are you in?"
  puts "Please enter their hobby"
  puts "To finish, just hit return three times"
  
  
  
  name = STDIN.gets.chomp
  cohort = STDIN.gets.chomp.to_sym
  hobby = STDIN.gets.chomp
  while !name.empty? do
      if cohort.empty?
        @students << {name: name, cohort: :unknown, hobby: hobby}
      else
        @students << {name: name, cohort: cohort, hobby: hobby}
      end
    if @students.length > 1
    puts "Now we have #{@students.count} students"
    else
    puts "Now we have #{@students.count} student"   
    end
    puts "Add another name"
    puts "Which cohort?"
    puts "Add another hobby"
    puts "To finish, just hit return three times"
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp.to_sym
    hobby = STDIN.gets.chomp
  end
  @students
end



def print_students_list(names)
  puts "Which cohort do you want to see?"
selected_cohort = STDIN.gets.chomp    
  puts "The students of Villains Academy #{selected_cohort} cohort".center(120)
  puts "-------------".center(120)



  names.each.with_index(1) do |student, i|
    if student[:cohort].to_s == selected_cohort
      puts "#{i}. #{student[:name]} (#{student[:cohort]} cohort), and their hobby is #{student[:hobby]}".center(120)
    end
  end
end

def print_footer(names)
  if names.count > 1
    puts "Overall, we have #{names.count} great students".center(120)
  else
    puts "Overall, we have #{names.count} great student".center(120)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  while @students.length > 0 do
           print_students_list(@students)
           print_footer(@students)
           break
  end
end


def process(selection)
  case selection
    when "1"
      @students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
     print_menu
     process(STDIN.gets.chomp)
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort, hobby = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby}
  end
  file.close
end

def try_load_students 
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu



