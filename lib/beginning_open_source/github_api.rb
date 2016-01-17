class BeginningOpenSource::GithubApi

  #i am passing around variables.  might be better off using class variables.  
	  @@array_of_issues = []

  def self.get_issues(input_string) #still very long.  refactor
      response = self.search_issues(input_string)

      puts "Total Issue count matching #{input_string}:".blue + " #{response["total_count"]}".red

      search_results = JSON.parse(response.body)["items"]

      loaded_repo_count = 1
      search_results.each do |issue| 
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

          if loaded_repo_count > 10 
            puts "loading #{loaded_repo_count}/30" 
          end
          loaded_repo_count += 1
          
          self.get_repository(issue_url_array[3], issue_url_array[4], hash_of_issue)

          @@array_of_issues << hash_of_issue

      end #end of each statement
      @@array_of_issues
       #there are pagination options.  
       # right now it is only giving me 30 per page.  can go up to 100
    end  #end of method

    def self.search_issues(input_string)
      if self.token == 'PASTE_TOKEN_HERE_AS_STRING' #doing this twice, but with a different url.  if i take in the url or have it set as a variable, i might be able to combine these
        response = HTTParty.get("https://api.github.com/search/issues?q=label:\"#{input_string}\"+language:ruby+state:open&sort=created&order=desc")
      else
        response = HTTParty.get("https://api.github.com/search/issues?q=label:\"#{input_string}\"+language:ruby+state:open&sort=created&order=desc",
          :headers => {
                  "Authorization" => "token #{self.token}",
                  "User-Agent" => self.agent
                  })
      end
      response
    end

    def self.get_repository(user, repository, hash)
          if self.token == 'PASTE_TOKEN_HERE_AS_STRING'
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