class API
    def self.get_list
        resp = RestClient.get("https://jobs.github.com/positions.json?description=&location=&page=3")
        jobs_arr = JSON.parse(resp.body, symbolize_names:true)
        jobs_arr.each do |job|
            Job.new(job)
        end
    end
end



