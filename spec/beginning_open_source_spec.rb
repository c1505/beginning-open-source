require 'spec_helper'

describe BeginningOpenSource do
  it 'has a version number' do
    expect(BeginningOpenSource::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end

describe "Issue" do 
  let!(:student_index_array) {[{:name=>"Alex Patriquin", :location=>"New York, NY"},
 {:name=>"Bacon McRib", :location=>"Kansas City, MO"},
 {:name=>"Alisha McWilliams", :location=>"San Francisco, CA"},
 {:name=>"Daniel Fenjves", :location=>"Austin, TX"},
 {:name=>"Arielle Sullivan", :location=>"Chicago, IL"},
 {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"},
 {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"}]}

 let!(:student_hash) {{:twitter=>"someone@twitter.com",
 :linkedin=>"someone@linkedin.com",
 :github=>"someone@github.com",
 :blog=>"someone@blog.com",
 :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
 :bio=>
  "I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school."}}


  let!(:issue) {BeginningOpenSource::Issues.new({:title=>"Alex Patriquin", :html_url=>"New York, NY"})}
  
  after(:each) do 
    BeginningOpenSource::Issues.class_variable_set(:@@all, [])
  end
  describe "#new" do
    it "takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash." do 
      expect{BeginningOpenSource::Issues.new({:title => "Sophie DeBenedetto", :html_url => "Brooklyn, NY"})}.to_not raise_error
      expect(issue.title).to eq("Alex Patriquin")
      expect(issue.html_url).to eq("New York, NY")
    end 

    it "adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable." do 
      expect(BeginningOpenSource::Issues.class_variable_get(:@@all).first.title).to eq("Alex Patriquin")
    end
  end
end