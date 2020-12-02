module Mechanic
  def self.change_params(req, name, second)

    Rack::Response.new do |response|
      response.set_cookie(name, req.cookies["#{name}"].to_i + 5) if req.cookies["#{name}"].to_i < 100
      response.set_cookie(second, req.cookies["#{second}"].to_i + 5) if req.cookies["#{second}"].to_i < 100
      need = ($NEEDS - [name]).sample

      response.set_cookie(need, req.cookies["#{need}"].to_i - 5 )
   
      response.redirect('/start')
    end
  end

  def self.gym(req, name)

    Rack::Response.new do |responses|
      responses.set_cookie(name, req.cookies["#{name}"].to_i + 1)

      responses.redirect('/gym')
    end
  end

  def self.shop(req, first, name, second)

    Rack::Response.new do |responses|
        responses.set_cookie(name, req.cookies["#{name}"].to_i  + 5) if req.cookies["#{name}"].to_i < 100 and req.cookies["#{second}"].to_i >= 10
        responses.set_cookie(first, req.cookies["#{first}"].to_i  + 5) if req.cookies["#{first}"].to_i < 100 and req.cookies["#{second}"].to_i >= 10 
        responses.set_cookie(second, req.cookies["#{second}"].to_i  - 10) if req.cookies["#{second}"].to_i >= 10 

        responses.redirect('/shop')
    end
  end

  def self.shopfish(req, first, name, second, third)

    Rack::Response.new do |responses|
        responses.set_cookie(name, req.cookies["#{name}"].to_i  + 5) if req.cookies["#{name}"].to_i < 100 and req.cookies["#{third}"].to_i >= 20
        responses.set_cookie(first, req.cookies["#{first}"].to_i  + 5) if req.cookies["#{first}"].to_i < 100 and req.cookies["#{third}"].to_i >= 20 
        responses.set_cookie(second, req.cookies["#{second}"].to_i  + 5) if req.cookies["#{second}"].to_i < 100 and req.cookies["#{third}"].to_i >= 20 
        responses.set_cookie(third, req.cookies["#{third}"].to_i  - 20) if req.cookies["#{third}"].to_i >= 20 

        responses.redirect('/shop')
    end
  end

  def self.shoppie(req, first, name, second, third,fourth)

    Rack::Response.new do |responses|
        responses.set_cookie(name, req.cookies["#{name}"].to_i  + 5) if req.cookies["#{name}"].to_i < 100 and req.cookies["#{fourth}"].to_i >= 30
        responses.set_cookie(first, req.cookies["#{first}"].to_i  + 5) if req.cookies["#{first}"].to_i < 100 and req.cookies["#{fourth}"].to_i >= 30 
        responses.set_cookie(second, req.cookies["#{second}"].to_i  + 5) if req.cookies["#{second}"].to_i < 100 and req.cookies["#{fourth}"].to_i >= 30 
        responses.set_cookie(third, req.cookies["#{third}"].to_i  + 5) if req.cookies["#{third}"].to_i < 100 and req.cookies["#{fourth}"].to_i >= 30 
        responses.set_cookie(fourth, req.cookies["#{fourth}"].to_i  - 30) if req.cookies["#{fourth}"].to_i >= 30 

        responses.redirect('/shop')
    end
  end
  

end