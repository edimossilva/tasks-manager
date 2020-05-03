class DeleteTestDataWorker
  # bundle exec sidekiq
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    test_user = User.find_by(username: 'test_user')

    task_lists = test_user.task_lists
    task_lists.destroy_all

    tasks = Task.where(user: test_user)
    tasks.destroy_all
  end
end
