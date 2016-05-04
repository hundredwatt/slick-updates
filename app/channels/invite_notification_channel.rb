# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class InviteNotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    Redis.current.setex("logged_in_#{current_user.id}", 1800, true)
    stream_from "logged_in_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    Redis.current.del("logged_in_#{current_user.id}")
  end
end
