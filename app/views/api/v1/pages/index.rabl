object @page
attributes :id, :url

node :stored_tags do |p|
  @stored_tags || @page.elements.pluck(:tag).uniq
end

child :elements =>'stored_elements' do |e|
  attributes :id, :tag, :html, :content, :href
end
