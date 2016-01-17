require_relative "beginning_open_source/version"
require_relative "beginning_open_source/github_api.rb"
require_relative "beginning_open_source/issues.rb"

File.open("../lib/secrets.rb", 'w'){|f| f.write("class BeginningOpenSource::GithubApi
  def self.token
    'PASTE_TOKEN_HERE_AS_STRING'
  end

  def self.agent
  	'PASTE_GITHUB_USERNAME_HERE_AS_STRING'
  end
end")}

require_relative "secrets.rb"
require_relative "cli"

require 'json'
require 'httparty'
# require 'pry' #just for development