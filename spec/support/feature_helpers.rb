module FeatureHelpers
  def set_cookie(key, value)
    headers = {}
    Rack::Utils.set_cookie_header!(headers, key, value)
    cookie_string = headers['Set-Cookie']
    Capybara.current_session.driver.browser.set_cookie(cookie_string)
  end

  def set_time_zone_cookie(time_zone_name)
    set_cookie("time_zone", time_zone_name)
  end
end
