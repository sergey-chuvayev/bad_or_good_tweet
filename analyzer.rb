require 'unirest'

class Analyzer

	def self.run(text, object)
		response = Unirest.post "https://russiansentimentanalyzer.p.mashape.com/ru/sentiment/polarity/json/",
		headers:{
		"X-Mashape-Key" => "ESsjZZ3XJVmshPAxe17V81GeLBsap1v9eC4jsnJYhcjVxORkEY",
		"Content-Type" => "application/json",
		"Accept" => "text/plain"
		},
		parameters: '{"text": "' + text + '","object_keywords":"' + object + '", "output_format": "json"}'
		return response.body['sentiment']
	end

end