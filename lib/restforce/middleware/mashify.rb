module Restforce
  # Middleware the converts sobject records from JSON into Restforce::SObject objects
  # and collections of records into Restforce::Collection objects.
  class Middleware::Mashify < Restforce::Middleware

    def call(env)
      @env = env
      response = @app.call(env)
      env[:body] = Restforce::Mash.build(body, client)
      response.env.body = env[:body]
      response
    end

    def body
      JSON.parse(@env[:body]) rescue @env[:body]
    end
  
  end
end
