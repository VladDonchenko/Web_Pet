require './app/lib/mechanic'
require "erb"

class Pet
	include Mechanic

	def self.call(env)
		new(env).response.finish
	end

	def initialize(env)
		@req    = Rack::Request.new(env)
		@food   = 40
		@health = 40
		@sleep  = 40
		@happy  = 40
		@money = 100
		@muscles = 30
		$NEEDS  = %w[health food sleep happy]
	end

	def response
		case @req.path
		when '/'
			Rack::Response.new(render("start.html.erb"))

		when '/initialize'
			Rack::Response.new do |response|
				response.set_cookie('health', @health)
				response.set_cookie('food', @food)
				response.set_cookie('sleep', @sleep)
				response.set_cookie('happy', @happy)
				response.set_cookie('drink', @drink)
				response.set_cookie('money', @money)
				response.set_cookie('muscles', @muscles)
				response.set_cookie('name', @req.params['name'])
				response.redirect('/start')
			end

		when '/exit'
			Rack::Response.new('Game Over', 404)
			Rack::Response.new(render("over.html.erb"))

		when '/gym'
			return Mechanic.gym(@req, 'muscles') if @req.params['muscles']
		 if get("muscles") >= 100
		 	Rack::Response.new('Красавчик кота прокачал, теперь иди и прокачивай себя')
		 	Rack::Response.new(render("index.html.erb"))
		 else
		 	Rack::Response.new(render("gym.html.erb"))
		 end

		 when '/shop'
		 	return Mechanic.shop(@req,'health', 'food', 'money') if @req.params['health']		 		
		 	Rack::Response.new(render("shop.html.erb"))

		 when '/shopfish'
		 	return Mechanic.shopfish(@req,'health', 'food', 'sleep', 'money') if @req.params['food']			 		
		 	Rack::Response.new(render("shop.html.erb"))

		 when '/shoppie'
		 	return Mechanic.shoppie(@req,'health', 'food', 'sleep', 'happy', 'money') if @req.params['happy']			 		
		 	Rack::Response.new(render("shop.html.erb"))

		when '/start'
			if get("health") <=0 || get("food") <= 0 || get("sleep") <= 0 || get("happy") <= 0 || get("muscles") <=0
				Rack::Response.new('Game Over', 404)
				Rack::Response.new(render("end.html.erb"))
			else
				Rack::Response.new(render("index.html.erb"))
			end

		when '/change'
			return Mechanic.change_params(@req, 'health', 'money') if @req.params['health']
			return Mechanic.change_params(@req, 'food', 'money')  if @req.params['food']
			return Mechanic.change_params(@req, 'sleep', 'money') if @req.params['sleep']
			return Mechanic.change_params(@req, 'happy',  'money') if @req.params['happy']
			return Mechanic.change_params(@req, 'drink',  'money')  if @req.params['drink']
			return Mechanic.change_params(@req, 'muscles',  'money') if @req.params['muscles']
			else
				Rack::Response.new('Not Found', 404)
			end
		end

	def render(template)
		path = File.expand_path("../../webpages/#{template}", __FILE__)
		ERB.new(File.read(path)).result(binding)
	end

	def name
		name = @req.cookies['name'].delete(' ')
		name.empty? ? 'Pet' : @req.cookies['name']
	end

	def get(attr)
		@req.cookies["#{attr}"].to_i
	end

	def check(param)
		if param >=100
			param = 100
		end
	end
end