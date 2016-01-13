require 'json'
require 'httparty'
require 'pry'
# require_relative 'secrets.rb' #commented out to debug
class GithubBeginner 

  @@array_of_issues = []

  def self.get_issues(input_string)
      if self.token == 'PASTE_TOKEN_HERE_AS_STRING' #doing this twice, but with a different url
        response = HTTParty.get("https://api.github.com/search/issues?q=label:\"#{input_string}\"+language:ruby+state:open&sort=created&order=desc")
      else
        response = HTTParty.get("https://api.github.com/search/issues?q=label:\"#{input_string}\"+language:ruby+state:open&sort=created&order=desc",
          :headers => {
                  "Authorization" => "token #{self.token}",   #hardcoding doesn't fix it
                  "User-Agent" => self.agent
                  })
      end
      puts "Total Issue count matching #{input_string}:".blue + " #{response["total_count"]}".red

      search_results = JSON.parse(response.body)["items"]

      
      count = 1

      puts "**Caution**\n
      If you don't provide a github token to authenicate, your search results will only return repository descriptions and stars once per hour due to github api restrictions".yellow

      search_results.each do |issue| #this is getting very long.  refactor.
          hash_of_issue = {}

          issue_url_array = issue["html_url"].split("/")
          hash_of_issue[:repo_name] = issue_url_array[4]
          repo_string = "https://api.github.com/repos/#{issue_url_array[3]}/#{issue_url_array[4]}"
          

          hash_of_issue[:title] = issue["title"]
          hash_of_issue[:labels] = (issue["labels"].map {|issue| issue["name"]})
          hash_of_issue[:body] = issue["body"]
          hash_of_issue[:html_url] = issue["html_url"]
          hash_of_issue[:created_at] = issue["created_at"]
          hash_of_issue[:repo_url] = repo_string


          if count > 10
            puts "loading #{count}/30" 
          end
          count += 1
          
          self.get_repository(issue_url_array[3], issue_url_array[4], hash_of_issue)

          # if self.token == 'PASTE_TOKEN_HERE_AS_STRING' #from here to the end of the string is something different.  
          #   #getting repo description and 
          #   repo_json = HTTParty.get(repo_string)
          # else
          #   repo_json = HTTParty.get(
          #     repo_string, 
          #     :headers => {
          #         "Authorization" => "token #{self.token}",   
          #         "User-Agent" => self.agent
          #         })
          # end

          # repo_parsed = JSON.parse(repo_json.body)
          # hash_of_issue[:repo_description] = repo_parsed["description"]
          # hash_of_issue[:stars] = repo_parsed["stargazers_count"]

          @@array_of_issues << hash_of_issue
          # array_of_issues

      end #end of each statement
      @@array_of_issues
       #there are pagination options.  
       # right now it is only giving me 30 per page.  can go up to 100
    end  #end of method
    def self.get_repository(user, repository, hash)
          if self.token == 'PASTE_TOKEN_HERE_AS_STRING' #from here to the end of the string is something different.  
            #getting repo description and 
            repo_json = HTTParty.get("https://api.github.com/repos/#{user}/#{repository}") 
          else
            repo_json = HTTParty.get(
              "https://api.github.com/repos/#{user}/#{repository}", 
              :headers => {
                  "Authorization" => "token #{self.token}",   
                  "User-Agent" => self.agent
                  })
          end

          repo_parsed = JSON.parse(repo_json.body)
          hash[:repo_description] = repo_parsed["description"]
          hash[:stars] = repo_parsed["stargazers_count"]
          hash
    end

end #end of class

class String
  #colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def green
    colorize(32)
  end

  def red
    colorize(31)
  end

end
