class HomeController < ApplicationController
  def track_event
    EppoClient::Client.instance.unstable_track(
      params[:event],
      { foo: "bar" }
    )

    render json: { message: "Event tracked" }
  end
end
