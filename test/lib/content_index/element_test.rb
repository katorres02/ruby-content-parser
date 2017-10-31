require 'test_helper'

class ContentIndex::ElementTest < ActiveSupport::TestCase

  test 'Element contains href' do
    page = ContentIndex::Page.new({url: 'https://github.com/sparklemotion/nokogiri'})
    element = page.search('a').first
    assert_not_nil element.href
  end

  test 'Element does not contain href' do
    page = ContentIndex::Page.new({url: 'https://github.com/sparklemotion/nokogiri'})
    element = page.search('h1').first
    assert_nil element.href
  end
end