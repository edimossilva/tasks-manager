module JsonResponseHelper
  def json_response_data
    JSON.parse(response.body)['data']
  end

  def json_response_error
    JSON.parse(response.body)['error_message']
  end

  def json_subject_data
    JSON.parse(subject)['data']
  end

  def json_subject_errors
    JSON.parse(subject)['errors']
  end

  def json_subject_status_code
    JSON.parse(subject)['headers']['status_code']
  end
end
