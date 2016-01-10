require 'json'
require 'httparty'
require 'pry'
class GithubBeginner 
  attr_accessor :result
  def intitialize
        @result = "ten"
  end

  def self.github_commits(user)
      #title
      #body
      #"html_url"
      

      response = HTTParty.get("https://api.github.com/search/issues?q=label:beginner+language:ruby+state:open&sort=created&order=asc")
      events = JSON.parse(response.body)
      events = events["items"]

      array_of_issues = []
      hash_of_issue = {}
      events.each do |f|
        hash_of_issue = {}
        hash_of_issue[:title] = f["title"]
        hash_of_issue[:body] = f["body"]
        hash_of_issue[:html_url] = f["html_url"]
        array_of_issues << hash_of_issue
      end

      binding.pry

       #there are only 30 titles and i'm not sure why
    end  
    

    def self.test_method
        "string"
    end
end

GithubBeginner.github_commits('c1505')