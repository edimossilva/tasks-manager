module JsonResponseHelper
  def json_response_data
    JSON.parse(response.body)['data']
  end

  def json_response_error
    JSON.parse(response.body)['error_message']
  end

  def subject_data
    subject[:data]
  end

  def subject_errors
    subject[:errors]
  end

  def subject_status_code
    subject[:headers][:status_code]
  end
end
