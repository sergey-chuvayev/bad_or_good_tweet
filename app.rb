require 'sinatra'


get '/' do
	erb :index
end

post '/analyze' do
	return Analyzer.run(params['text'], params['object'])
end

get '/analyze' do
	content_type :json
	sentiment = Analyzer.run(params['text'], params['object'])
  	return { :sentiment => sentiment }.to_json
end