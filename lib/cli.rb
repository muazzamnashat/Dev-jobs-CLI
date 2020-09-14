class CLI

attr_reader :all_location, :all_language ,:job_number

def all_locations
    @all_location = []
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
    @all_language = []
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
    all_languages.each.with_index(1) do |language,index|
        puts "#{index}. #{language}."
    end   
end

def print_by_location_and_language(location,language)
    @job_number = []
    Job.all.sort_by{|job_instance|job_instance.title}.each.with_index(1) do |job,index|
        if job.location == location && job.description.include?(language)
            job_number << index
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
            puts "The job number is #{index}"
            puts "#{job.title}"
            puts "This is a #{job.type} position "
            puts "The name of the company is #{job.company}and the location will be #{job.location}."
            puts "You can learn about the company here : #{job.company_url}"
            puts "To know more about the position please click here: #{job.url}"
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue) 
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
        end
    end
end

def read_description(num)
    Job.all.sort_by{|job_instance|job_instance.title}.each.with_index(1) do |job,index|
        if index == num
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
            puts "#{job.description}".gsub(Regexp.union(['<p>','</p>','<ul>','</ul>','<li>','</li>','<strong>','</strong>',"<a>","</a>","<href>","</href>","<a","href=","<em>","</em>","  "]), '').strip
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
            puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)

        end
    end
end

def print_appropriate_job_listing(input_loc,input_lan)
    puts "The list is loading please wait"
            print_by_location_and_language(input_loc,input_lan)
            puts "To read job description, select the job number"
            input_jn = gets.strip

            until job_number.include?(input_jn.to_i)
                if input_jn.downcase == "exit"
                    abort "Thank you for using the app!".colorize(:blue)
                end
                puts "Please select a valid number!".colorize(:red)
                input_jn=gets.strip
            end

            read_description(input_jn.to_i)
            puts "Do you want to search again? (y/n)"
            input = gets.strip

            if input.downcase == "y"
                play
            elsif input.downcase == "n"
                puts "Thank you for using the app!".colorize(:blue)
            end
            
end

def check?(location,language)
    Job.all.sort_by{|name|name.title}.any? do |job|
        job.location == location && job.description.include?(language)
    end
end

def print_only_when_match(input_loc,input_lan)
    if check?(input_loc,input_lan)
        print_appropriate_job_listing(input_loc,input_lan)
    else
        puts "Job is not available for this particular selection,sorry! Let's try again.".colorize(:red)
        sleep(3)
        play
    end
end

def play

    puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
    puts "--------------------------------------------------------------------------------------------------------------------------------".colorize(:blue)
    puts ""
    puts "Welcome to the Job Search CLI program! You can exit anytime typing 'Exit'."
    puts "Let's find your dream job!"
    sleep (2)
    puts " "
    puts "Here are the available locations :"
    puts " "
    print_locations
    puts " "
    puts "Please type in your preferred location"
    input_loc = gets.strip.capitalize

    if input_loc == "Exit"
        abort "Thank you for using the app!".colorize(:blue)
    end

    if all_location.include?(input_loc)
        puts "Okay cool! Now, I'll load in the available programming languages!"
        print_languages
        puts "Please type your in favourite language."
        input_lan = gets.strip.capitalize

        until all_language.include?(input_lan)
            if input_lan == "Exit"
                abort "Thank you for using the app!".colorize(:blue)
            end
            puts "Please type an appropriate language!".colorize(:red)
            input_lan = gets.strip.capitalize
        end
        print_only_when_match(input_loc,input_lan)

    else
        puts "Please type an appropriate location!".colorize(:red)
        puts "The program is starting again!"
        sleep(3)
        play
        
    end

end

end
