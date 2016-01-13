# require_relative "../lib/github_beginner.rb" #commented out to debug
class Issues
  attr_accessor :title, :html_url, :repo_name, :repo_description, :body, :stars, :created_at, :labels, :repo_url

  @@all = []

  @@starred = []

  def initialize(issues_hash)
    issues_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
    unless @stars == nil
      if @stars > 0          
      	@@starred << self
      end
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