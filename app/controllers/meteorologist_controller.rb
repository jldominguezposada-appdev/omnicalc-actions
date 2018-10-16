require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================

    url_google_api="https://maps.googleapis.com/maps/api/geocode/json?address=#{sanitized_street_address}&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    
        parsed_data_a = JSON.parse(open(url_google_api).read)
        
        latitude = parsed_data_a.dig("results", 0, "geometry", "location", "lat")
        
        longitude = parsed_data_a.dig("results", 0, "geometry", "location", "lng")

    url_darksky_api = "https://api.darksky.net/forecast/816f5ce55ff2f4e620d861bfbab9e4d4/#{latitude.to_s},#{longitude.to_s}"
    
        parsed_data_b = JSON.parse(open(url_darksky_api).read)
        
    # Output:
        
    @current_temperature = parsed_data_b.dig("currently", "temperature")

    @current_summary = parsed_data_b.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_data_b.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_data_b.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_data_b.dig("daily", "summary")
    
    
    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
