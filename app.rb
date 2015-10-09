require 'sinatra'
require_relative 'analyzer'

require 'sinatra'

get '/' do
	erb :index
end

post '/analyze' do
	Analyzer.run(params['text'],'текст')
end