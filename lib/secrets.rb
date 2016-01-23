class BeginningOpenSource::GithubApi #should probably change to a module or just ask user for input
  def self.token
    'PASTE_TOKEN_HERE_AS_STRING'
  end

  def self.agent
  	'c1505'
  end

  def self.token?
  	if self.token == 'PASTE_TOKEN_HERE_AS_STRING'
  		false
  	else
  		true
  	end
  end
end