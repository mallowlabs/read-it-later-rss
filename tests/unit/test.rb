# frozen_string_literal: true

require 'minitest/autorun'
require 'rack/test'

require_relative '../../app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert(last_response.ok?)
    assert_includes(last_response.body, 'Pocket')
  end

  def test_index_with_name
    get '/?name=john'
    assert_equal(last_response.status, 302)
  end

  def test_name
    get '/john'
    assert(last_response.ok?)
    assert_includes(last_response.body, 'john')
  end
end
