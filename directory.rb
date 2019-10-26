@students = []  

def student_push(name, cohort, hobby) 
  @students << {name: name, cohort: cohort, hobby: hobby}
end

def input_students

  while true do
    puts "Please enter the names of the students"
    puts "Which cohort are you in?"
    puts "Please enter their hobby"
    puts "To finish, just hit return three times"
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp.to_sym
    hobby = STDIN.gets.chomp
    
    if name.empty?
      break
    elsif cohort.empty?
      student_push(name, :unknown, hobby)
    else
      student_push(name, cohort, hobby)
    end
    
    if @students.length > 1
      puts "Now we have #{@students.count} students"
    else
      puts "Now we have #{@students.count} student"   
    end
    
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
      puts "Action succesful!"
      save_students
    when "4"
      puts "Action succesful!"
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
  File.open("students.csv", "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:hobby]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
end

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort, hobby = line.chomp.split(',')
      student_push(name, cohort, hobby)
    end
  end
end

def try_load_students 
  filename = ARGV.first
  if filename.nil?
    load_students()
      puts "Loaded #{@students.count} from students.csv"
  elsif File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu



