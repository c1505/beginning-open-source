class BeginningOpenSource::CLI

	def call
		welcome
		list_beginner_issues
		search_issues
		goodbye
	end

	def welcome
		puts "Welcome to beginning open source!".blue
		puts "Viewing open github issues labeled 'beginner' within the ruby language".blue
		puts " "
		puts "With this tool, you can find issues on github by label".blue
	end

	def list_beginner_issues #by default, it will return issues in github repos with 1 star or more
		get_and_print('beginner')
	end

	def search_issues
		input = nil
		while input != "exit"
			puts "\n" + "Enter the issue label you would like to search for or type 'exit'".green
			input = gets.chomp.scan(/[a-z\s]/).join
			unless input == 'exit' 
				get_and_print(input)
			end
			# list_issues #do i want to return all issues or just the last searched ones.  i'm thinking last searched
		#possibly could store the other in memory to retrieve again if i want
		end
	end

	def goodbye 
		puts "Happy learning!"
	end

	def get_and_print(input_string)
		issues_array = BeginningOpenSource::GithubApi.get_issues(input_string)
		
		BeginningOpenSource::Issues.create_from_collection(issues_array)
		if BeginningOpenSource::Issues.starred.empty?
			BeginningOpenSource::Issues.all.each do |issue|
				length = "Repository Url: #{issue.repo_url}".length
				puts " "
				puts "Issue Title: #{issue.title}".blue
				puts "Repository Name: #{issue.repo_name}"
				puts "Repository Description: #{issue.repo_description}"
				puts "Stars: #{issue.stars}"
				puts "Labels: #{issue.labels}"
				puts "Issue Url: #{issue.html_url}"
				puts "Repository Url: #{issue.repo_url}"
				length.times {print "*"}
			end
		else
			BeginningOpenSource::Issues.starred.each do |issue|
				length = "Repository Url: #{issue.repo_url}".length
				puts " "
				puts "Issue Title: #{issue.title}".blue
				puts "Repository Name: #{issue.repo_name}"
				puts "Repository Description: #{issue.repo_description}"
				puts "Stars: #{issue.stars}"
				puts "Labels: #{issue.labels}"
				puts "Issue Url: #{issue.html_url}"
				puts "Repository Url: #{issue.repo_url}"
				length.times {print "*"}
			end
		end
end

end