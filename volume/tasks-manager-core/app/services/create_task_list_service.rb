class CreateTaskListService
  include Auth::JsonWebTokenHelper

  def call(payload)
    payload_json = JSON.parse(payload)
    name = payload_json['name']
    description = payload_json['description']
    frequence_type = payload_json['frequenceType']
    puts "#{name}, #{description}, #{frequence_type}"
  end

  private

  def exp_time
    time = Time.zone.now + 24.hours.to_i
    time.strftime('%m-%d-%Y %H:%M')
  end

  def auth_data(user)
    {
      headers: { "status_code": 200 },
      payload: {
        data: {
          token: encode_user(user),
          exp: exp_time,
          username: user.username,
          userId: user.id
        }
      }
    }
  end

  def unauthorized_data
    {
      headers: { "status_code": 401 },
      payload: {
        errors: [{
          error_message: 'unauthorized :('
        }]
      }
    }
  end
end
