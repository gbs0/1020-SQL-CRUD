require 'sqlite3'
require 'pry'

DB = SQLite3::Database.new('doctor.db')

class Doctor
    def initialize(attr = {})
        @id = attr[:id] || nil
        @name = attr[:name]
        @age = attr[:age]
        @specialty = attr[:specialty]
    end
    
    def save
      query = "INSERT INTO doctors (name, age, specialty) VALUES (?, ?, ?)"
      DB.execute(query, @name, @age, @specialty)
      @id = DB.last_insert_row_id
    end

    def self.display
      DB.results_as_hash = true
      results = DB.execute("SELECT * FROM doctors;")
      results.each do |doctor|
        puts "ID: #{doctor["id"]} | Name: #{doctor["name"]} | Age: #{doctor["age"]} | Specialty: #{doctor["specialty"]}"
      end
    end
end



doctor = Doctor.new(name: "Dr. Mario",age: 45, specialty: "Plumber")
# doctor.save
Doctor.display
