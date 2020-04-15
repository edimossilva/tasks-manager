class TaskInListPolicy
  attr_reader :user, :task_in_list

  def initialize(user, task_in_list)
    @user = user
    @task_in_list = task_in_list
  end

  def owner?
    user.owner?(task_in_list)
  end
end
