require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'byebug'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
  end

  # response_array = [status, header, body]
  # response_array = [302, {'Content-Type' => 'text/html'}, body]

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'error' if already_built_response?
    @res.status = 302
    @res['Location'] = url
    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'error' if already_built_response?
    @res.write(content)
    @res['Content-Type'] = content_type
    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    path = File.dirname(__FILE__)
    file_path = File.join(path, "..", 'views', self.class.to_s.underscore, "#{template_name}.html.erb")
    content_type = File.read(file_path)
    content = ERB.new(content_type).result(binding)
    render_content(content, 'text/html')
  end

  # method exposing a `Session` object
  def session
    
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end

