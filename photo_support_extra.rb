module Plugin::PhotoSupportExtra
  GITHUB_IMAGE_PATTERN = %r<\Ahttps://github\.com/(\w+/\w+)/blob/(.*\.(#{GdkPixbuf::Pixbuf.formats.flat_map do |f| f.extensions end.join '|'}))\z>
end

Plugin.create(:photo_support_extra) do
  defimageopener('github', Plugin::PhotoSupportExtra::GITHUB_IMAGE_PATTERN) do |display_url|
    url = Plugin::PhotoSupportExtra::GITHUB_IMAGE_PATTERN.match(display_url) do |m|
      "https://raw.githubusercontent.com/#{m[1]}/#{m[2]}"
    end
    pp url
    $stdout.flush
    open(url) if url
  end
end
