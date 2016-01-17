class BeginningOpenSource::CLI

	def call
		puts "hello world"
		list_issues
		search_issues
		goodbye
	end

	def list_issues #by default, it will return issues in github repos with 1 star or more
		puts "1. issue 1"
		puts "2. issue 2"
	end

	def search_issues
		puts "Enter the issue label you would like to search for or type 'exit'"
		input = gets.chomp.scan(/[a-z\s]/).join
		unless input == 'exit'
			#call search method
			list_issues #do i want to return all issues or just the last searched ones.  i'm thinking last searched
		end
		#possibly could store the other in memory to retrieve again if i want
	end

	def menu
		puts "Enter the number of the issue you would like to see more information about or type exit"
		input = nil # use new method i discovered 
		while input != "exit"
			input = gets.strip.downcase
			case input #will have at least 30, can't do a case statement.  
			when "1"
				puts "More info on issue 1"
			when "2"
				puts "more info on issue 2"
			when "list" #this might not make sense.  search instead?
				list_issues
			else
				puts "Not sure what you want.  type list or exit"
			end
		end
		#list issues
		#list all issues
		#search for additional issues
	end

	def goodbye 
		puts "Happy learning!"
	end

end