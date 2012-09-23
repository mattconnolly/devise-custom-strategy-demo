# a custom strategy can be define like so:
Warden::Strategies.add :simple_strategy do

  # it must have a `valid?` method to check if it is appropriate to use
  # for a given request
  def valid?
    @env['HTTP_X_MY_API'].present?
  end

  # it must have an authenticate! method to perform the validation
  # a successful request calls `success!` with a user object to stop
  # other strategies and set up the session state for the user logged in
  # with that user object.
  def authenticate!
    # if the authentication header is an acceptible value
    if @env['HTTP_X_MY_API'] == 'foobar'
      user = { :id => 1, :name => "some user" }
      # warden doesn't care what the user is, so long as it's not nil.
      success! user, "success"
    end
  end
end

