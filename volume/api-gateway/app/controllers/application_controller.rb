class ApplicationController < Sinatra::Base
  disable :show_exceptions

  set :raise_errors, true
  set :dump_errors, false
  set :show_exceptions, false

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
    status 415
    json({ data: params })
  end

  def render_unauthorized
    status 401
    json({ data: 'unauthorized :(' })
  end

  def render_server_unavailable(message = 'service unavailabe :(')
    status 503
    json({ data: message })
  end

  def render_response(response_dto)
    status response_dto.status_code
    json response_dto.data
  end
end
