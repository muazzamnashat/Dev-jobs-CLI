require 'rest-client'
require 'json'
require 'pry'
require_relative 'job'

resp= RestClient.get("https://jobs.github.com/positions.json?description=&location=&page=3")
jobs_hash=JSON.parse(resp.body, symbolize_names:true)
job_array=jobs_hash.collect do |job|
    Job.new
end


binding.pry