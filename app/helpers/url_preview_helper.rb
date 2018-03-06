module UrlPreviewHelper
  require 'link_thumbnailer'

  def preview_url(url)
    begin
      LinkThumbnailer.generate(url)
    rescue LinkThumbnailer::Exceptions => e
      nil
    rescue Net::ReadTimeout
      nil
    end
  end
end