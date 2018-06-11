Plugin.create(:photo_support_extra) do
  defimageopener('marshmallow-qa', %r<\Ahttps?://marshmallow-qa\.com/messages/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}>) do |display_url|
    connection = HTTPClient.new
    page = connection.get_content(display_url)
    next nil if page.empty?
    doc = Nokogiri::HTML(page)
    result = doc.css('meta[property="og:image"]').first
    open(result.attribute('content').to_s)
  end
end
