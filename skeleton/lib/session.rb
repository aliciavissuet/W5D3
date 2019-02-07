require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  attr_reader :cookie
  
  def initialize(req)
    # @cookie = req.cookies["_rails_lite_app"]
    # @cookie ? @cookie = JSON.parse(@cookie) : @cookie

    if req.cookies["_rails_lite_app"]
      @cookie = JSON.parse(req.cookies["_rails_lite_app"])
    else
      @cookie = {}
    end

  end

  def [](key)
    self.cookie[key]
    #session[:session_token]
  end

  def []=(key, val)
    self.cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie("_rails_lite_app", { path: "/", value: "#{@cookie.to_json}" })
    # p res
    # res["_rails_lite_app"] = @cookie.to_json
  end
end

#<Rack::Request:0x00007fb06955a9f8 @params=nil, @env={"rack.input"=>{}, "rack.request.cookie_hash"=>{"_rails_lite_app"=>"{\"xyz\":\"abc\"}"}}>

# <Rack::Response:0x00007ffe792a5510 @status=200, @header={}, @writer=#<Proc:0x00007ffe792a53f8@/usr/local/var/rbenv/versions/2.5.0/lib/ruby/gems/2.5.0/gems/rack-2.0.6/lib/rack/response.rb:32 (lambda)>, @block=nil, @length=0, @body=[]>
