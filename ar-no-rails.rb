require "rubygems"
require "bundler/setup"
require "active_record"

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/app/models/*.rb").each { |f| require f }

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
#ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
#ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
#ActiveRecord::Migrator.migrate("db/migrate/")

# run from PowerShell
# rake db:drop; rake db:create; rake db:migrate; ruby .\ar-no-rails.rb


overall_past = Time.now
2.times do |m|
  past = Time.now
  1000.times do |n|
    jrrt = Author.create(first_name: "JRR", last_name: "Tolkien #{n}")
    Author.create(first_name: "Jane", last_name: "Austen")
    Author.create(first_name: "Philip", last_name: "Pullman", full_content: "<xml>Test</xml>")
  end
  1000.times do |n|
    jrrt = Author.find_by last_name: "Tolkien #{n}"
    lord_of_the_rings = Book.create(title: "The Lord of the Rings", author: jrrt)
    Book.create(title: "Pride and Prejudice", author: jrrt)
    Book.create(title: "His Dark Materials", author: jrrt)
    manBookerPrize = Award.create(name: "Man Booker Prize")
    commonwealthBookPrize = Award.create(name: "Commonwealth Book Prize")
    AwardPresentation.create(award: manBookerPrize, author: jrrt)
    AwardPresentation.create(award: commonwealthBookPrize, author: jrrt)
  end
  print("Insert statement took #{Time.now-past} seconds\n")

  print("Number of authors in database: #{Author.all.size}\n")
  past = Time.now
  100.times do |n|
    jrrt = Author.find_by last_name: "Tolkien #{n}"
    Author.all.map { |a| a.full_name }.join(', ')
    Book.where("title like ?", "Dark").map { |b| b.title }.join(', ')
    #select[Author].where(_.lastName :== "Pullmann").foreach(a => println(a.full_content))
    Author.where(last_name: "Pullmann").each { |a| print(a.full_content) }
  end
  print("Select statement took #{Time.now-past} seconds\n")
end
print("Overall execution took #{Time.now-overall_past} seconds\n")
