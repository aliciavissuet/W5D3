require 'rack'


app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res['Location'] = "/i/love/app/academy"
  if req.path == "/i/love/app/academy"
    res.write("/i/love/app/academy")
  else
    res.write("hello world")
  end
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)