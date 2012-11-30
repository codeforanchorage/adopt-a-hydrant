require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminPublish
end
 
module RailsAdmin
  module Config
    module Actions
      class EmailEveryone < RailsAdmin::Config::Actions::Base
        # There are several options that you can set here. 
        # Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info.
        register_instance_option :visible? do
          authorized?
        end
        
        register_instance_option :link_icon do
          'icon-envelope'
        end
                
        register_instance_option :collection do
          true
        end
 
        register_instance_option :controller do
          Proc.new do
            # Get all hydrants with users
            @hydrants_with_users = Thing.where('user_id IS NOT NULL')
 
            # Update field published to true
            @hydrants_with_users.each do |hydrant|
              from_user = User.find_by_email('adoptahydrant@ci.anchorage.ak.us')
              @reminder = Reminder.new(:thing_id=>hydrant.id, :to_user_id => hydrant.user.id, :from_user_id => from_user.id)
              if @reminder.save
                ThingMailer.reminder(@reminder.thing).deliver
                @reminder.update_attribute(:sent, true)
              else
                logger.error "Error sending email reminder: "+ @reminder.errors.full_messages.map {|msg| msg}.join(',')
              end
            end
            
            flash[:success] = "#{@model_config.label}s successfully sent."
            
            redirect_to back_or_index
          end
        end
      end
    end
  end
end