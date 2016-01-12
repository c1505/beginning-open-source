require_relative "../lib/github_beginner.rb"
class Issues
  attr_accessor :title, :html_url, :repo_name, :repo_description, :body, :stars, :created_at, :labels

  @@all = []

  @@starred = []

  def initialize(issues_hash)
    issues_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
    if stars > 0
    	@@starred << self
    end
  end

  def self.create_from_collection(issues_array)
    issues_array.each do |issue|
      Issues.new(issue)
    end
  end

  def self.all
    @@all
  end

  def self.starred
  	@@starred
  end

end