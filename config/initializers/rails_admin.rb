require Rails.root.join('lib', 'rails_admin_email_everyone.rb')
RailsAdmin.config do |config|
  config.authenticate_with do
    redirect_to(main_app.root_path, flash: {warning: "You must be signed-in as an administrator to access that page"}) unless signed_in? && current_user.admin?
  end
  # Register the class in lib/rails_admin_publish.rb
  module RailsAdmin
    module Config
      module Actions
        class EmailEveryone < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end

  config.actions do
    # root actions
    dashboard                     # mandator y
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app

    # Set the custom action here
    email_everyone do
      # Make it visible only for reminder model. You can remove this if you don't need.
      visible do
        bindings[:abstract_model].model.to_s == "Reminder"
      end
    end
  end
end
