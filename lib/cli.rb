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
        all_location.each.with_index(1) do |location,index|
            puts "#{index}. #{location}."
        end
        
    end


end
binding.pry