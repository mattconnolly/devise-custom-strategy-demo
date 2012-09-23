module MyAuthentication
  class CustomStrategy < Devise::Strategies::Authenticatable

    # it must have a `valid?` method to check if it is appropriate to use
    # for a given request
    def valid?
      # must call this to actually get the authentication_hash set:
      # valid_for_http_auth?

      # but, we want this strategy to be valid for any request with this header set so that we can use a custom
      # response for an invalid request.
      @env['HTTP_X_MY_API'].present?
      true
    end


    # it must have an authenticate! method to perform the validation
    # a successful request calls `success!` with a user object to stop
    # other strategies and set up the session state for the user logged in
    # with that user object.
    def authenticate!

      # mapping comes from devise base class, "mapping.to" is the class of the model
      # being used for authentication, typically the class "User". This is set by using
      # the `devise` class method in that model
      klass = mapping.to

      if @env['HTTP_X_MY_API'].present?
        # the returned user object will be saved and serialised into the session
        user = klass.find_or_initialize_by_email(@env['HTTP_X_MY_API'])
        success! user
      end

      # if we wanted to stop other strategies from authenticating the user
    end


    private


    # send a 401 back to the client so they can make another request.
    # a 401 MUST include the 'WWW-Authenticate' header as per spec.
    # This will also halt warden from allowing any other strategies to continue.
    def challenge!
      response_headers = { "WWW-Authenticate" => %(Basic realm="My Application"), 'Content-Type' => 'text/plain' }
      response_headers['X-WHATEVER'] = "some other value"
      body = "401 Unauthorized"
      response = Rack::Response.new(body, 401, response_headers)
      custom! response.finish
    end

    # send a 400 back to the client: bad request
    # This will also halt warden from allowing any other strategies to continue.
    def deny!
      body = %(This is an unauthorised request. Your IP address has been logged and will be reported.)
      response_headers = { 'Content-Type' => 'text/plain' }
      response = Rack::Response.new(body, 400, response_headers)
      custom! response.finish
    end

  end
end

# for warden, `:my_authentication`` is just a name to identify the strategy
Warden::Strategies.add :my_authentication, MyAuthentication::CustomStrategy

# for devise, there must be a module named 'MyAuthentication' (name.to_s.classify), and then it looks to warden
# for that strategy. This strategy will only be enabled for models using devise and `:my_authentication` as an
# option in the `devise` class method within the model.
Devise.add_module :my_authentication, :strategy => true

