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

  def render_unprocessable_entity(params)
    status 415
    json({ data: params })
  end
end
