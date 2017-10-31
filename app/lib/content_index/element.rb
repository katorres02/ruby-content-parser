module ContentIndex
  class Element
    attr_accessor :html, :content, :tag, :href

    def initialize(params = {})
      @content = params[:content]
      @html    = params[:html]
      @tag     = params[:tag]
      @href    = validate_link(params[:original])
    end

    private
    
    # only for links
    # check if the element contain href attribute
    def validate_link(element)
      if element.attributes.keys.include?('href')
        @href = element.attributes['href'].value
      end
    end
  end
end
