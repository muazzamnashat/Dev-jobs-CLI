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
        # API.get_list
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
        Job.all.sort_by{|name|name.title}.each.with_index(1) do |job,index|
            if job.location == location && job.description.include?(language)

            puts "The job number is #{index}"
            puts "#{job.title}"
            puts "This is a #{job.type} position "
            puts "The name of the company is #{job.company}and the location will be #{job.location}."
            puts "You can learn about the company here : #{job.company_url}"
            puts "To know more about the position please click here: #{job.url}"
            puts "--------------------------------------------------------------------------------------------------------------------------------"
            puts "--------------------------------------------------------------------------------------------------------------------------------" 
            puts "--------------------------------------------------------------------------------------------------------------------------------"
            end
        end
        
    end

    def read_description(num)
        Job.all.sort_by{|name|name.title}.each.with_index(1) do |job,index|
            # binding.pry
            if index == num
                puts "#{job.description}".gsub(Regexp.union(['<p>','</p>','<ul>','</ul>','<li>','</li>']), ' ')
               #.gsub(Regexp.union(['<p>','</p>','<ul>','</ul>','<li>','</li>']), ' ')
            end
        end
    end

end

new=CLI.new
new.print_locations
# new.print_by_location_and_language("Remote","C")
new.read_description(22)
binding.pry

