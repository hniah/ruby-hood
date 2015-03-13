module V1
  class Consumers < Grape::API
    resource :consumer do
      desc 'Create a new consumer'

      params do
        requires :email, type:String
        requires :device_token, type:String
      end

      post do
        consumer = Consumer.find_by_device_token(params[:device_token])
        if consumer.present?
          ApiHelper.response(200, 'Consumer has been created before', consumer)
        else
          consumer = Consumer.new({
              name:params[:name],
              email:params[:email],
              device_token:params[:device_token],
              platform:params[:platform]
          })
          if consumer.save
            ApiHelper.response(200, 'Consumer was inserted successfully', consumer)
          else
            ApiHelper.response(500, 'Consumer was inserted unsuccessfully')
          end
        end
      end


      desc 'Store consumer social post'

      params do
        requires :consumer_id, type:String
        requires :vendor_id, type:String
        requires :message, type:String
        requires :social_type, type:String
      end

      post 'social' do

        post = Post.new({
            consumer_id:  params[:consumer_id],
            vendor_id:    params[:vendor_id],
            message:      params[:message],
            picture:      params[:picture],
            social_type:  params[:social_type]
        })

        if post.save
          data_vendor = Vendor.find(params[:vendor_id]).data_vendor
          data_vendor = data_vendor.present? ? ApiHelper.filter_reward_vendor(data_vendor) : nil

          ApiHelper.response(200, 'Post was inserted successfully', data_vendor)
        else
          ApiHelper.response(500, 'Post was inserted unsuccessfully')
        end

      end

    end
  end
end
