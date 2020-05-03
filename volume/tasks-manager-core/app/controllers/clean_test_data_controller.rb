class CleanTestDataController < ApplicationController
  skip_before_action :authorize_request, only: [:index]

  def index
    DeleteTestDataWorker.perform_async
    render_destroyed
  end
end
