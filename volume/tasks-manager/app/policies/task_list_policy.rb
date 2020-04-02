class TaskListPolicy
  attr_reader :user, :task_list

  def initialize(user, task_list)
    @user = user
    @task_list = task_list
  end

  def owner?
    user.owner?(task_list)
  end
end
