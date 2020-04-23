module ResponsesDto
  module_function

  def server_unavailable(error_message = 'server_unavailable :(')
    response_hash = {
      headers: {
        status_code: 503
      },
      data: {
        errors: [
          error_message: error_message
        ]
      }.to_json
    }

    ResponseDto.new(response_hash)
  end
end
