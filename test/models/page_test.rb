require 'test_helper'

class PageTest < ActiveSupport::TestCase

  test 'valid page' do
    page = Page.new(url: 'http://www.google.com')
    assert page.valid?
  end

  test 'invalid without url' do
    page = Page.new
    assert_not page.valid?
    assert_not_empty page.errors[:url]
  end

  test 'invalid with url saved before' do
    page_1 = Page.new(url: 'http://www.google.com')
    page_1.save
    
    page_2 = Page.new(url: 'http://www.google.com')
    page_2.save

    assert_not page_2.valid?
    assert_not_empty page_2.errors[:url]
  end
end
