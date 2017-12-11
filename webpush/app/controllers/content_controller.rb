class ContentController < ApplicationController
	def sendPush
		notif_data = NotificationDatum.create(endpoint: params[:subscription][:endpoint],
		                        p256dh_key: params[:subscription][:keys][:p256dh],
		                        auth_key: params[:subscription][:keys][:auth])
		User.where(auth_key: params[:subscription][:keys][:auth]).destroy_all
		user = User.create(auth_key: params[:subscription][:keys][:auth], :notif_id => notif_data.id)
		sendPayload(user)
		render body: nil
	end

	def sendPayload(user)
	    @message = get_message(user.name)
	    if user.notif_id.present?
	      @notification_data = NotificationDatum.find(user.notif_id)
	      Webpush.payload_send(endpoint: @notification_data.endpoint,
	                           message: @message,
	                           p256dh: @notification_data.p256dh_key,
	                           auth: @notification_data.auth_key,
	                           ttl: 24 * 60 * 60,
	                           vapid: {
	                               subject: 'mailto:admin@commercialview.com.au',
	                               public_key: $vapid_public,
	                               private_key: $vapid_private
	                           }
	      )
	      puts "success"
	    else
	      puts "failed"
	    end
    end

    def get_message(name)
    	"Hello World"
    end
end
