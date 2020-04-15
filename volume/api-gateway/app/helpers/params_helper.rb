module ParamsHelper
  def ok_headers
    {
      status_code: '200'
    }
  end

  def unauthorized_headers
    {
      status_code: '401'
    }
  end
end
