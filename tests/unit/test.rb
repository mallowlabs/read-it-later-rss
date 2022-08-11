# frozen_string_literal: true

require 'minitest/autorun'
require 'rack/test'
require 'webmock/minitest'

require_relative '../../app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    WebMock.disable_net_connect!
  end

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

  def test_unread
    rss = <<-RSS
      <?xml version="1.0" encoding="UTF-8"?><rss version="2.0"
          xmlns:atom="http://www.w3.org/2005/Atom"
      >

      <channel>

      <title>My Reading List: Unread</title>
      <description>Items I've saved to read</description>
      <link>http://readitlaterlist.com/users/john/feed/unread</link>
      <atom:link href="http://readitlaterlist.com/users/john/feed/unread" rel="self" type="application/rss+xml" />


      <item>
      <title>test-title</title>
      <category>Unread</category>
      <link>https://example.com/</link>
      <guid>https://example.com/</guid>
      <pubDate>Tue, 02 Aug 2022 04:58:57 -0500</pubDate>
      </item>
      </channel>

      </rss>
    RSS
    stub_request(:get, 'https://getpocket.com/users/john/feed/unread').
      to_return(status: 200, body: rss, headers: { content_type: 'application/rss+xml' }
    )

    get '/john/unread'
    assert(last_response.ok?)
    assert_includes(last_response.body, 'test-title')
  end
end
