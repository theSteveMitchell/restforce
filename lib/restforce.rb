require 'faraday'
require 'faraday_middleware'
require 'json'

require 'restforce/version'
require 'restforce/config'

module Restforce
  autoload :AbstractClient, 'restforce/abstract_client'
  autoload :SignedRequest,  'restforce/signed_request'
  autoload :Collection,     'restforce/collection'
  autoload :Middleware,     'restforce/middleware'
  autoload :Attachment,     'restforce/attachment'
  autoload :UploadIO,       'restforce/upload_io'
  autoload :SObject,        'restforce/sobject'
  autoload :Client,         'restforce/client'
  autoload :Mash,           'restforce/mash'

  module Concerns
    autoload :Authentication, 'restforce/concerns/authentication'
    autoload :Connection,     'restforce/concerns/connection'
    autoload :Picklists,      'restforce/concerns/picklists'
    autoload :Streaming,      'restforce/concerns/streaming'
    autoload :Caching,        'restforce/concerns/caching'
    autoload :Canvas,         'restforce/concerns/canvas'
    autoload :Verbs,          'restforce/concerns/verbs'
    autoload :Base,           'restforce/concerns/base'
    autoload :API,            'restforce/concerns/api'
  end

  module Data
    autoload :Client, 'restforce/data/client'
  end

  module Tooling
    autoload :Client, 'restforce/tooling/client'
  end

  Error               = Class.new(StandardError)
  AuthenticationError = Class.new(Error)
  UnauthorizedError   = Class.new(Error)
  UnsupportedError    = Class.new(Error)

  class << self
    # Alias for Restforce::Data::Client.new
    #
    # Shamelessly pulled from https://github.com/pengwynn/octokit/blob/master/lib/octokit.rb
    def new(*args)
      data(*args)
    end

    def data(*args)
      Restforce::Data::Client.new(*args)
    end

    def tooling(*args)
      Restforce::Tooling::Client.new(*args)
    end

    # Helper for decoding signed requests.
    def decode_signed_request(*args)
      SignedRequest.decode(*args)
    end
  end

  # Add .tap method in Ruby 1.8
  module CoreExtensions
    def tap
      yield self
      self
    end
  end
  Object.send :include, Restforce::CoreExtensions unless Object.respond_to? :tap
end
