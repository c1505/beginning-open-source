require 'json'
require 'httparty'
require 'pry'

class GithubBeginner 
  
  def self.get_issues
      #need to select everything between 3 and 5th forward slash

      #repo name
      response = HTTParty.get("https://api.github.com/search/issues?q=label:beginner+language:ruby+state:open&sort=created&order=asc")
      events = JSON.parse(response.body)
      events = events["items"]

      array_of_issues = []
      hash_of_issue = {}
      events.each do |f|
        hash_of_issue = {}
        hash_of_issue[:title] = f["title"]
        # hash_of_issue[:body] = f["body"]  #uncomment
        #above commented out because the large amount of output makes it difficult 
        #to see what is going on.


        hash_of_issue[:html_url] = f["html_url"]
        split_url = f["html_url"].split("/")
        repo_string = "https://api.github.com/repos/#{split_url[3]}/#{split_url[4]}"

        # hash_of_issue[:repo_url] = repo_string

        #now that i have the repo_url
        repo_json = HTTParty.get(repo_string)

        repo_parsed = JSON.parse(repo_json.body)
        
        hash_of_issue[:repo_description] = repo_parsed["description"]




        array_of_issues << hash_of_issue
        binding.pry
        
      end
        # binding.pry
      
      
      # puts array_of_issues
       #there are pagination options.  
       # right now it is only giving me 30 per page.  can go up to 100
    end  
end


GithubBeginner.get_issues