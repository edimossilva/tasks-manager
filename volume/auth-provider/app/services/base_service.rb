class BaseService
  include Auth::JsonWebTokenHelper

  protected

  def unauthorized_data
    {
      headers: { status_code: 401 },
      payload: {
        errors: [{
          error_message: 'unauthorized :('
        }]
      }
    }
  end

  def status_code_ok
    { status_code: 200 }
  end
end
