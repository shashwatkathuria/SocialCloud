RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Clearance ==
  # config.parent_controller = "::ApplicationController"
  #
  # config.authorize_with do |controller|
  #   unless current_user && current_user.email == "shashwat@gmail.com"
  #     redirect_to(
  #       main_app.root_path,
  #       alert: "You are not permitted to view this page"
  #     )
  #   end
  # end
  config.authorize_with do |controller|
    if current_user.nil?
      redirect_to '\404.html'
    elsif !(current_user.email == "shashwat@gmail.com")
      redirect_to '\404.html'
    end
  end
  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

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
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
