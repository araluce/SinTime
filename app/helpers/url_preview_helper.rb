module UrlPreviewHelper
  require 'link_thumbnailer'

  def preview_url(url)
    LinkThumbnailer.generate(url)
  end
end