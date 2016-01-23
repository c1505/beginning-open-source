class BeginningOpenSource::GithubApi

  def self.get_issues(input_string) #still very long.  refactor
    response = self.get_json("https://api.github.com/search/issues?q=label:\"#{input_string}\"+language:ruby+state:open&sort=created&order=desc")

    puts "Total Issue count matching #{input_string}:".blue + " #{response["total_count"]}".red

    response["items"].each_with_index.map do |issue, index| 
        hash_of_issue = {}

        issue_url_array = issue["html_url"].split("/")

        hash_of_issue[:repo_name] = issue_url_array[4]
        hash_of_issue[:title] = issue["title"]
        hash_of_issue[:labels] = (issue["labels"].map {|issue| issue["name"]})
        hash_of_issue[:body] = issue["body"]
        hash_of_issue[:html_url] = issue["html_url"]
        hash_of_issue[:created_at] = issue["created_at"]
        hash_of_issue[:repo_url] = "https://github.com/#{issue_url_array[3]}/#{issue_url_array[4]}"
        
        repo_json = self.get_json("https://api.github.com/repos/#{issue_url_array[3]}/#{issue_url_array[4]}")

        hash_of_issue[:repo_description] = repo_json["description"]
        hash_of_issue[:stars] = repo_json["stargazers_count"]

        if index > 10 
          puts "loading #{index + 1}/30" 
        end
        hash_of_issue
    end
  end

  def self.get_json(url)
      unless self.token?
        HTTParty.get(url) 
      else
        HTTParty.get(
          url, 
          :headers => {
              "Authorization" => "token #{self.token}",   
              "User-Agent" => self.agent
              })
      end
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
  #use class variables to not pass them between methods?

       #there are pagination options.  
       # right now it is only giving me 30 per page.  can go up to 100