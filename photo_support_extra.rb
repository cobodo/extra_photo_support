Plugin.create(:photo_support_extra) do
  defimageopener('xkcd', %r<\Ahttps?://xkcd\.com/[0-9]+>) do |display_url|
    connection = HTTPClient.new
    page = connection.get_content(display_url)
    next nil if page.empty?
    doc = Nokogiri::HTML(page)
    result = doc.css('#comic > img').first
    src = result.attribute('srcset').to_s.split(' ').first
    if src.start_with?('//')
      src = Diva::URI.new(display_url).scheme + ':' + src
    end
    open(src)
  end
  defimageopener('imgur', %r<\Ahttps?://imgur\.com/[a-zA-Z0-9]+>) do |display_url|
    connection = HTTPClient.new
    page = connection.get_content(display_url)
    next nil if page.empty?
    doc = Nokogiri::HTML(page)
    result = doc.css('link[rel="image_src"]').first
    open(result.attribute('href').to_s)
  end
end
