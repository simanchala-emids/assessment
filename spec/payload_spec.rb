require 'spec_helper'

describe Payload do

  describe "#new" do

    it "returns an object with instace variable count is zero when passing other parameter instead of hash" do
      payload = Payload.new ["payload", "payload1"]
      expect(payload).to be_an_instance_of Payload
      expect(payload.instance_variables.size).to eq(0)
    end

    it "returns an object with instace variable count is zero when parameter is blank" do
      payload = Payload.new
      expect(payload).to be_an_instance_of Payload
      expect(payload.instance_variables.size).to eq(0)
    end

    it "returns an object with instace variable count is zero when hash parameter doesn't have properties key" do
      params = {
        "payload":{
          "id": 49,
          "options": {
            "devices": "ios => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
            "alert_message": " You have following notifications ",
            "badge_count":10,
            "created_at":"2015-07-20T06:28:36-05:00",
            "id":48,"member_id":25,"notification_type": "secure_message",
            "silent":true,"updated_at":"2015-07-20T06:28:36-05:00"
          }
        }
      }
      payload = Payload.new params
      expect(payload).to be_an_instance_of Payload
      expect(payload.instance_variables.size).to eq(0)
    end

    it "returns an object with instace variable count is zero when hash parameter doesn't have payload key" do
      params = {
        "properties": {
          "user_id":43,"managing_user_id":43,"description":"Push Notification",
          "effective_date":"2015-07-20T06:28:36-05:00","system_date":"2015-07-20T06:28:36-05:00"
        }
      }
      payload = Payload.new params
      expect(payload).to be_an_instance_of Payload
      expect(payload.instance_variables.size).to eq(0)
    end

    it "returns an object with instace variable count is zero when hash parameter doesn't have options key inside payload key" do
      params = {
        "properties": {
          "user_id":43, "managing_user_id":43, "description":"Push Notification",
          "effective_date":"2015-07-20T06:28:36-05:00", "system_date":"2015-07-20T06:28:36-05:00"
        },
        "payload":{"id": 49}
      }
      payload = Payload.new params
      expect(payload).to be_an_instance_of Payload
      expect(payload.instance_variables.size).to eq(0)
    end



    it "returns a new payload object when passing correct hash parameter for secure_message" do
      params = {
        "properties": {
          "user_id":43,"managing_user_id":43,"description":"Push Notification",
          "effective_date":"2015-07-20T06:28:36-05:00","system_date":"2015-07-20T06:28:36-05:00"
        },
        "payload":{
          "id": 49,
          "options": {
            "devices": "ios => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
            "alert_message": " You have following notifications ","badge_count":10,
            "created_at":"2015-07-20T06:28:36-05:00","id":48,"member_id":25,
            "notification_type": "secure_message","silent":true,"updated_at":"2015-07-20T06:28:36-05:00"
          }
        }
      }
      payload = Payload.new params
      expect(payload).to be_an_instance_of Payload
      expect(payload.instance_variables.size).to eq(7)
      expect(payload.user_id).to eq(43)
      expect(payload.publish_at).to eq("2015-07-20T06:28:36-05:00")
      expect(payload.message).to eq(" You have following notifications 10")
      expect(payload.message_type).to eq("secure_message")
      expect(payload.pop_up).to eq(true)
      expect(payload.target).to eq("ios")
      expect(payload.device_id).to eq("e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96")
    end


    it "returns a new payload object when passing correct hash parameter" do
      params = {
        "properties": {
          "user_id": 43,"managing_user_id": 43,"description": "Push Notification",
          "effective_date": "2015-07-21T06:28:36-05:00","system_date": "2015-07-21T06:28:36-05:00"
        },
        "payload":{
          "id": 48,
          "options": {
            "devices": "android => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
            "alert_message": "This is a sample push notification message","badge_count": 0,
            "created_at": "2015-07-21T06:28:36-05:00","id":48,"member_id": 25,"notification_type": "Reminder",
            "silent": false,"updated_at": "2015-07-21T06:28:36-05:00"
          }
        }
      }
      payload = Payload.new params
      expect(payload).to be_an_instance_of Payload
      expect(payload.instance_variables.size).to eq(7)
      expect(payload.user_id).to eq(43)
      expect(payload.publish_at).to eq("2015-07-21T06:28:36-05:00")
      expect(payload.message).to eq("This is a sample push notification message")
      expect(payload.message_type).to eq("Reminder")
      expect(payload.pop_up).to eq(false)
      expect(payload.target).to eq("android")
      expect(payload.device_id).to eq("e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96")
    end

    context '#validate_params' do
      it 'should return false if parameter is blank' do
        payload = Payload.new
        validate_params = payload.validate_params?
        expect(validate_params).to eq(false)
      end

      it 'should return false if parameter is not in hash' do
        payload = Payload.new
        validate_params = payload.validate_params? ["payload", 'payload1']
        expect(validate_params).to eq(false)
      end

      it 'should return false if parameter is empty hash' do
        payload = Payload.new
        validate_params = payload.validate_params? {}
        expect(validate_params).to eq(false)
      end

      it 'should return true if parameter type is hash and contain properties, payload and options  inside payload keys' do
        payload = Payload.new
        params = {
          "properties": {
            "user_id": 43,"managing_user_id": 43,"description": "Push Notification",
            "effective_date": "2015-07-21T06:28:36-05:00","system_date": "2015-07-21T06:28:36-05:00"
          },
          "payload":{
            "id": 48,
            "options": {
              "devices": "android => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
              "alert_message": "This is a sample push notification message","badge_count": 0,
              "created_at": "2015-07-21T06:28:36-05:00","id":48,"member_id": 25,"notification_type": "Reminder",
              "silent": false,"updated_at": "2015-07-21T06:28:36-05:00"
            }
          }
        }
        validate_params = payload.validate_params? params
        expect(validate_params).to eq(true)
      end
    end

    context '#get_alert_message' do
      it "should return alert message only when silent key is false" do
        payload = Payload.new
        params =  {
          "devices": "android => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
          "alert_message": "This is a sample push notification message","badge_count": 0,
          "created_at": "2015-07-21T06:28:36-05:00","id":48,"member_id": 25,"notification_type": "Reminder",
          "silent": false,"updated_at": "2015-07-21T06:28:36-05:00"
        }
        expect(payload.get_alert_message params).to eq("This is a sample push notification message")
      end

      it "should return alert message with badge_count only when silent key is false" do
        payload = Payload.new
        params =  {
          "devices": "android => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
          "alert_message": "You have following notifications ","badge_count": 10,
          "created_at": "2015-07-21T06:28:36-05:00","id":48,"member_id": 25,"notification_type": "Secure Message",
          "silent": true,"updated_at": "2015-07-21T06:28:36-05:00"
        }
        expect(payload.get_alert_message params).to eq("You have following notifications 10")
      end
    end


  end
end
