require 'rest-client'
require 'json'
require 'pry'
require_relative 'job'

resp= RestClient.get("https://jobs.github.com/positions.json?description=&location=&page=3")
jobs_arr=JSON.parse(resp.body, symbolize_names:true)
job_instances=jobs_arr.collect do |job|
  
    Job.new(job)
end
# binding.pry


