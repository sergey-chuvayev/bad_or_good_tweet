require 'unirest'
require 'sqlite3'

class Analyzer

	def self.run(text, object)
		response = Unirest.post "https://russiansentimentanalyzer.p.mashape.com/ru/sentiment/polarity/json/",
		headers:{
		"X-Mashape-Key" => "ESsjZZ3XJVmshPAxe17V81GeLBsap1v9eC4jsnJYhcjVxORkEY",
		"Content-Type" => "application/json",
		"Accept" => "text/plain"
		},
		parameters: '{"text": "' + text + '","object_keywords":"' + object + '", "output_format": "json"}'
		puts response.body
		return response.body['sentiment']
	end

	def self.analyze_db
		@db = SQLite3::Database.new "./db/database.db"
		
		users = @db.execute('SELECT * FROM users')

		users.each do |user|
			messages = @db.execute("SELECT * FROM messages WHERE messages.user_id = #{user[0]} LIMIT 100")
			sentiment = { bad: 0, good: 0, neutral: 0 }
			messages.each do |message|
				mood_str = run(message[3],'')
				case mood_str
				when "NEGATIVE"
					sentiment[:bad] += 1
				when "POSITIVE"
					sentiment[:good] += 1
				when "NEUTRAL"
					sentiment[:neutral] += 1
				end
			end
			puts user[0]
			puts @db.execute("SELECT * FROM users WHERE users.id = #{user[0]}")
			puts sentiment
		end

	end

end

Analyzer.analyze_db