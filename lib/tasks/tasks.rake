task :lint do
  sh "bundle exec rubocop"
end

namespace :lint do
  task :fix do
    sh "bundle exec rubocop -a"
  end

  namespace :fix do
    task :force do
      sh "bundle exec rubocop -A"
    end
  end
end

task :test do
  sh "bundle exec rspec"
end
