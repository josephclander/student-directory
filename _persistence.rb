# frozen_string_literal: false

# save student data to file
def save_students
  # we have the data so it's ok to overwrite it
  puts "\nEnter a filename to save to".green
  filename = $stdin.gets.strip
  filename = filename == '' ? 'student.csv' : filename
  CSV.open(filename, 'w') do |csv|
    @students.each do |student|
      csv << [student[:name], student[:age], student[:birthplace], student[:cohort]]
    end
  end
  # TODO: Is is possible to have error messages from this process?
  puts "\n📝 Saved #{@students.size} student#{@students.count == 1 ? '' : 's'} to ".green + filename.to_s.red
end

# load student data from  file
def load_students(filename)
  # HACK: Removed default in param so not asked file name on load
  if filename.nil?
    puts "\nEnter a filename to load from".green
    filename = $stdin.gets.strip
    filename = filename == '' ? 'student.csv' : filename
  end
  File.open(filename) do |file|
    CSV.foreach(file) do |line|
      name, age, birthplace, cohort = line
      @students << { name: name, age: age, birthplace: birthplace, cohort: cohort }
    end
  end
  # TODO: Is is possible to have error messages from this process?
  puts "\n📝 Loaded #{@students.size} student#{@students.count == 1 ? '' : 's'} from ".green + filename.to_s.red
end

# try and load student data
def try_load_students
  filename = ARGV.first
  return if filename.nil?

  if File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end
