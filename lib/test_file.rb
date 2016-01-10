require 'json'
require 'httparty'
require 'pry'
class Commit 
  attr_accessor :result
  def intitialize
        @result = "ten"
  end

  def self.github_commits(user)
          
      response = HTTParty.get("https://api.github.com/users/#{user}/events/public")
      events = JSON.parse(response.body)
      @commit_messages = []
      @created_at = []
      events.each do |event|
          if event["type"] == "PushEvent"

              @commit_messages << event["payload"]["commits"][0]["message"]
              @created_at << event["created_at"]
                  
          end
      end
       @commit_messages
       binding.pry
    end  
    

    def self.test_method
        "string"
    end
end

Commit.github_commits('c1505')
#this code works to get commit messages from the api