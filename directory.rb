def input_students
  puts "Please enter the names of the students"
  puts "Which cohort are you in?"
  puts "Please enter their hobby"
  puts "To finish, just hit return three times"
  
  students = []
  
  name = gets.chomp
  cohort = gets.chomp.to_sym
  hobby = gets.chomp
  while !name.empty? do
      if cohort.empty?
    students << {name: name, cohort: :unknown, hobby: hobby}
      else
        students << {name: name, cohort: cohort, hobby: hobby}
      end
    if students.length > 1
    puts "Now we have #{students.count} students"
    else
    puts "Now we have #{students.count} student"   
    end
    puts "Add another name"
    puts "Which cohort?"
    puts "Add another hobby"
    name = gets.chomp
    cohort = gets.chomp.to_sym
    hobby = gets.chomp
  end
  students
end



def print(names)
  puts "Which cohort do you want to see?"
selected_cohort = gets.chomp    
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

def interactive_menu
  students = []    
  loop do
     puts "1. Input the students"
     puts "2. Show the students"
     puts "9 Exit"
     
     selection = gets.chomp
     
     case selection
       when "1"
         students = input_students
       when "2"
         while students.length > 0 do
           print(students)
           print_footer(students)
           break
         end
       when "9"
         exit
       else
         puts "I don't know what you meant, try again"
     end
      
  end
end

interactive_menu



