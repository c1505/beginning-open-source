require 'json'
require 'httparty'
require 'pry'
require_relative 'secrets.rb'
class GithubBeginner 

  def self.get_issues
      #need to select everything between 3 and 5th forward slash

      #currently searching for beginner
      response = HTTParty.get("https://api.github.com/search/issues?q=label:beginner+language:ruby+state:open&sort=created&order=desc")
      events = JSON.parse(response.body)
      events = events["items"]

      array_of_issues = []
      count = 1
      puts "**Caution**\n
      If you don't provide a github token to authenicate, you can only view repository names once per hour due to github api restrictions".yellow

      events.each do |f| #this is getting very long.  refactor.
          hash_of_issue = {}
          hash_of_issue[:title] = f["title"]
          hash_of_issue[:labels] = (f["labels"].map {|f| f["name"]})
          # hash_of_issue[:body] = f["body"]  #uncomment
          #above commented out because the large amount of output makes it difficult 
          #to see what is going on.
          hash_of_issue[:html_url] = f["html_url"]
          hash_of_issue[:created_at] = f["created_at"]
          split_url = f["html_url"].split("/")
          hash_of_issue[:repo_name] = split_url[4]
          repo_string = "https://api.github.com/repos/#{split_url[3]}/#{split_url[4]}"

          # hash_of_issue[:repo_url] = repo_string #uncomment maybe

          # binding.pry
          # raise "this"
          # Exception.new("")
          repo_json = HTTParty.get(
            repo_string, 
            :headers => {
                "Authorization" => "token #{self.token}",
                "User-Agent" => "c1505"
                })

          puts "loading #{count}/30" # change this to only doing it on odd times
          count += 1
          repo_parsed = JSON.parse(repo_json.body)
          
          hash_of_issue[:repo_description] = repo_parsed["description"]
          hash_of_issue[:stars] = repo_parsed["stargazers_count"]
          array_of_issues << hash_of_issue
          array_of_issues
          # binding.pry
      end

      # array_of_issues.each do |f|
      #   puts "Repo name" + f[:repo_name]
      #   puts "Repo description #{f[:repo_description]}"
      #   puts "Issue title" + f[:title]
      # end

      #   puts "Repo name: #{array_of_issues[0][:repo_name]}\nRepo description: #{array_of_issues[0][:repo_description]}\nIssue title: #{array_of_issues[0][:title]}\nLink to issue: #{array_of_issues[0][:html_url]}\nIssue body: #{array_of_issues[0][:body]}"


      #   puts "Repo description #{array_of_issues[0][:repo_description]}"
      #   puts "Issue title" + array_of_issues[0][:title]


      array_of_issues
       #there are pagination options.  
       # right now it is only giving me 30 per page.  can go up to 100
    end  
end

class String
  #colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def yellow
    colorize(33)
  end
end





# GithubBeginner.get_issues