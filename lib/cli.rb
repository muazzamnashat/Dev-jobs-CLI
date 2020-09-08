require_relative 'job'
require_relative 'api'
require 'pry'

class CLI
attr_accessor :all_locations

    def all_locations
        @all_location=[]
        API.get_list
        Job.all.each do |job|
           
            @all_location << job.location
           
        end
        @all_location.uniq
    end

    def print_locations
        all_locations.each.with_index(1) do |location,index|
            puts "#{index}. #{location}."
        end
        
    end


def print_by_location (location)
    Job.all.each do |job|

                if job.location.downcase == location.downcase
                    
                        puts    "#{job.title}"
                        puts    "This is a #{job.type} position "
                        puts    "The name of the company is #{job.company} and the location will be #{job.location}"
                        puts "You can learn about the company here : #{job.company_url}"
                        puts "To know more about the position please click here: #{job.url}"
                        puts "--------------------------------------------------------------------------------------------------------------------------------"
                        puts "--------------------------------------------------------------------------------------------------------------------------------"    
                end

            end
end


end
binding.pry