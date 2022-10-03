# frozen_string_literal: false

# choose option from input
def process(selection)
  case selection
  when '1' then input_students
  when '2' then print_students_list
  when '3' then save_students
  when '4' then load_students(nil)
  when '9' then exit
  else
    puts "I don't know what you meant, try again"
  end
end

# user menu options
def interactive_menu
  loop do
    print_menu
    process($stdin.gets.chomp)
  end
end
