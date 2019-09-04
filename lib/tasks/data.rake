namespace :data do
  desc "Populate DB with users and answers"
  task :populate => :environment do
    # TODO: 1,000,000 users with 1,000 answers each
    # Write a rake task to populate the DB with 1,000,000 users randomly
    # distributed across time zones in US, Europe and Asia. For each user,
    # generate 1,000 answers. The answer records should have the “created_at”
    # timestamps distributed over the last 6 months, and be randomly “correct”.
  end
end
