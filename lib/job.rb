class Job
    
attr_accessor :type, :company, :url, :company_url, :location, :title, :description, :how_to_apply

@@all =[]

def initialize(job)
    self.type= job[:type]
    self.company=job[:company]
    self.url=job[:url]
    self.company_url=job[:company_url]
    self.location=job[:location]
    self.title=job[:title]
    self.description=job[:description]
    self.how_to_apply=job[:how_to_apply]
    @@all << self  
end

def self.all
    @@all 
end

end