RailsAdmin.config do |config|
    config.parent_controller = "::ApplicationController"

  config.authorize_with do |controller|
    unless current_user && current_user.admin?
      cookies.delete(:auth_token)
      redirect_to(
        main_app.login_url,
        alert: "You don't seem to be admin, you can log in and continue  your work"
      )
    end
  end
  config.model 'User' do
    object_label_method do
      :custom_label_method
    end
  end

  def custom_label_method
    "#{first_name} #{last_name}"
  end
  
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  config.current_user_method { current_user }

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    # bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
