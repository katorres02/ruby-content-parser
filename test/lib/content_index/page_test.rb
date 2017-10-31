require 'test_helper'

class ContentIndex::PageTest < ActiveSupport::TestCase
  
  def setup
    @page = ContentIndex::Page.new({url: 'https://github.com/sparklemotion/nokogiri'})
  end

  test "Raise error when url is null" do
    assert_raises TypeError do 
      page = ContentIndex::Page.new({})
    end
  end

  test "Parse html when url is present" do
    page = ContentIndex::Page.new({url: 'http://www.google.com'})
    assert_equal   'http://www.google.com', page.url
    assert_not_nil page.body
    assert_empty   page.result
  end

  test "Search and find for h1 tags" do
    result = @page.search("h1")
    r = result.collect {|x| x.tag }.uniq
    assert_equal ["h1"], r
  end

  test "Search and find for h2 tags" do
    result = @page.search("h2")
    r = result.collect {|x| x.tag }.uniq
    assert_equal ["h2"], r
  end

  test "Search and find for h3 tags" do
    result = @page.search("h3")
    r = result.collect {|x| x.tag }.uniq
    assert_equal ["h3"], r
  end

  test "Search and find for 'a' tags" do
    result = @page.search("a")
    r = result.collect {|x| x.tag }.uniq
    assert_equal ["a"], r
  end

  test "Tag not found" do
    result = @page.search("canvas")
    r = result.collect {|x| x.tag }.uniq
    assert_equal [], r
  end

  test "Number of elements by tag found" do
    result = @page.search("h1")
    assert_equal 2, result.count
  end

  test "List tags loaded in memory" do
    @page.search("h1")
    @page.search("h2")
    @page.search("h3")
    @page.search("a")
    assert_equal ["h1", "h2", "h3", "a"], @page.tags
  end

  test "Load specific tag info" do
    assert_equal @page.search("h1"), @page.tag("h1")
  end
end
