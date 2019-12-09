namespace :data do
  desc "Populate DB with users and answers"
  task :populate => :environment do
    # TODO: 100,000 users with 1,000 answers each. See TASKS.md
    nu, na = 100000, 1000
    correct = [true, false]
    timezone = TZInfo::Timezone.all_identifiers.select{|i| i =~ /^(US|Europe|Asia)\// }

    ActiveRecord::Base.connection.truncate(:users)
    ActiveRecord::Base.connection.truncate(:answers)

	puts "Populating DB with #{nu} users with #{na} answers each"
	users = []
	nu.times do |i|
	  users << User.new(id: i+1,
	                  name: "User #{i+1}",
	              timezone: timezone.sample)
	end
	User.import users, validate: false

	nu.times do |i|
	  print "\r[#{(i+1)*100/nu}%] Processing... #{i+1} "
	  answers = []
	  na.times do |j|
	    answers << Answer.new(id: na*i+j+1,
	                     user_id: i+1,
	                     correct: correct.sample,
	                  created_at: rand(6*30).days.ago.to_s(:db))
	  end
	  Answer.import answers, validate: false
	end

    puts ""
  end
end
