class Api::V1::PagesController < ApiController

  # retrieve data from database
  def index
    @page = Page.find_by(url: params[:id])
    if @page.nil?
      return render json: { message: 'Page not found', status: 'error' }, status: 404
    end
    # continue to render json with rabl gem
  end

  # create or override tags info
  def create
    url  = params[:url]
    if !params[:tags].present?
      return render json: { message: 'Target tags are not present' }, sttaus: 404
    end

    tags = params[:tags].split(',')

    @page = Page.find_or_initialize_by(url: params[:url])
    
    if @page.new_record?
      @page.save
    end 
    
    # refresh data stored in case the web page has changed
    @page.elements.destroy_all if @page.elements.count > 0
    
    parse_html = ContentIndex::Page.new({url: @page.url})
    tags.each do |tag|
      data = parse_html.search(tag)
      data.each do |d|
        @page.elements.create(tag: tag, content: d.content, html: d.html, href: d.href)
      end
    end
    
    @stored_tags = parse_html.tags
    # use the json template of index
    render 'index'
  end
end
