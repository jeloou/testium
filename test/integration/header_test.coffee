{getBrowser} = require '../../lib/index'
assert = require 'assertive'

describe 'headers', ->
  before ->
    @browser = getBrowser()

  describe 'can be retireved', ->
    before ->
      @browser.navigateTo '/'
      assert.equal 200, @browser.getStatusCode()

    it 'as a group', ->
      headers = @browser.getHeaders()
      contentType = headers['content-type']
      assert.equal "text/html", contentType

    it 'individually', ->
      contentType = @browser.getHeader('content-type')
      assert.equal "text/html", contentType

  describe 'can be set', ->
    before ->
      @browser.navigateTo '/echo',
        headers:
          'x-something': 'that place'

    it 'to new values', ->
      source = @browser.getElement('body').get('text')
      body = JSON.parse source
      assert.equal body.headers['x-something'], 'that place'

