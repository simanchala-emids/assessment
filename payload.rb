require 'pry'
class Payload
  attr_accessor :user_id, :message, :message_type, :pop_up, :publish_at, :target, :device_id


  def initialize options = {}
    if validate_params? options
      payload_options, properties = options[:payload][:options], options[:properties]
      @user_id = properties[:user_id]
      @publish_at = properties[:effective_date]
      @message = get_alert_message payload_options
      @message_type = payload_options[:notification_type]
      @pop_up = payload_options[:silent]
      @target = payload_options[:devices].split(' => ')[0]
      @device_id = payload_options[:devices].split(' => ')[1]
    end

  end


  def validate_params? options = {}
    options.is_a?(Hash) && ((options.keys & [:properties, :payload]).size == 2) && ((options[:payload].keys & [:options]).size == 1)
  end

  def get_alert_message payload_options = {}
    payload_options[:alert_message] << payload_options[:badge_count].to_s if payload_options[:silent]
    payload_options[:alert_message]
  end
end
