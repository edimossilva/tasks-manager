class ApplicationController < Sinatra::Base
  disable :show_exceptions

  attr_reader :body_params

  before do
    request.body.rewind
    request_body = request.body.read
    @body_params = if !request_body.empty?
                     JSON.parse request_body
                   else
                     {}
                   end
  end

  protected

  def auth_header_token
    env['HTTP_AUTHORIZATION']
  end

  def render_unprocessable_entity(params)
    binding.pry
    status 415
    json({ data: params })
  end

  def render_unauthorized
    status 401
    json({ data: 'unauthorized :(' })
  end

  def render_error(response)
    status response[:headers][:status_code] || response[:headers]['status_code']
    json JSON.parse(response[:data])
  end
end
