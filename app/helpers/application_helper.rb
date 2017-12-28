module ApplicationHelper
  def page_title(text)
    content_for :title, text
  end

  def set_clock(clock)
    content_for :clock, clock
  end

  def legal_warning_text
    %q(Unauthorized access to this system is forbidden and will be
        prosecuted by law. By accessing this system, you agree that your
        actions may be monitored if unauthorized usage is suspected.
        By logging in, users agree to comply with the terms of the
        Nazaries Information Technologies policies.)
  end
end
