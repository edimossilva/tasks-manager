class ResponseDto
  attr_reader :status_code, :data, :response

  def initialize(response)
    @response = response
    headers = response['headers'] || response[:headers]
    @status_code = headers['status_code'] || headers[:status_code]
    data = JSON.parse(response[:data] || response['data'])
    @data = data['data'] || data
  end

  def success?
    status_code >= 200 && status_code < 300
  end

  def error?
    !success?
  end
end
