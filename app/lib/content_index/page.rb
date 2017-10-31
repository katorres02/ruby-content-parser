module ContentIndex
  require 'nokogiri'
  require 'open-uri'

  class Page
    attr_reader :url, :body, :result

    # initialize url and get the html content
    def initialize(params = {})
      @url    = params[:url]
      @body   = Nokogiri::HTML( open(@url) )
      @result = {}
    end

    # search by html tag, create an instance of Element object and store the result in variable
    def search( tag )
      @result[tag] = []
      @body.css(tag).each do |element|
        res = ContentIndex::Element.new({ original: element, content: element.content, html: element.to_s, tag: tag })
        @result[tag].push(res)
      end
      @result[tag]
    end

    # list of searched tags
    def tags
      @result.keys
    end

    # tag elements data
    def tag(tag)
      @result[tag]
    end
  end
end
