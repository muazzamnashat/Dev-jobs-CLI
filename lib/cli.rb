require_relative 'job'
require_relative 'api'
require 'pry'

class CLI
attr_accessor :all_location, :all_language

    def all_locations
        @all_location=[]
        API.get_list
        Job.all.each do |job|
           
            @all_location << job.location.capitalize
           
        end
        @all_location.uniq
    end

    def print_locations
        all_locations.each.with_index(1) do |location,index|
            puts "#{index}. #{location}."
        end
        
    end


    def all_languages
        @all_language=[]
        API.get_list
        Job.all.each do |job|
        
        if job.description.include?("Python")
            @all_language << "Python"
        elsif job.description.include?("Javascript")
            @all_language << "Javascript"
        elsif job.description.include?("Java")
            @all_language << "Java"
        elsif job.description.include?("C++")
            @all_language << "C++"
        elsif job.description.include?("C#")
            @all_language << "C#"
        elsif job.description.include?("C")
            @all_language << "C"
        elsif job.description.include?("Ruby")
            @all_language << "Ruby"
        end
        end
        @all_language.uniq
    
    end

    def print_languages
        all_languages.each.with_index(1) do |lan,index|
            puts "#{index}. #{lan}."
        end   
    end

def print_by_location_and_language(location,language)
    Job.all.each do |job|
        if job.location == location && job.description.include?(language)
        puts "The location is #{job.location}"
        end
    end
    
end

end
binding.pry