require "nokogiri"
require "open-uri"
require "uri"
require "net/http"

class Amazon
  def initialize(url)
    raise ArgumentError.new("Invalid URL") unless url =~ URI::regexp

    @url = url
    @response = fetch_page(url)
  end

  def fetch_page(url)
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    request["Accept-Language"] = "en-US,en;q=0.9"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"

    begin
      response = http.request(request)

      case response.code.to_i
      when 200
        Nokogiri::HTML(response.body)
      when 302, 301
        new_location = response["location"]
        if new_location
          puts "Przekierowanie do: #{new_location}"
          fetch_page(new_location)
        else
          raise "Przekierowanie bez nowego URL"
        end
      else
        raise "HTTP error: #{response.code}"
      end
    rescue StandardError => e
      puts "Błąd: #{e.message}"
      nil
    end
  end




  def title
    return "Title not available" if @response.nil?
    @title ||= @response.css("span#productTitle").text.strip
  end

  def price
    return "Price not available" if @response.nil?
    whole_price = @response.css("span.a-price-whole").first&.text&.strip
    fraction_price = @response.css("span.a-price-fraction").first&.text&.strip
    @price ||= whole_price.nil? ? "Price not available" : "#{whole_price}#{fraction_price}"
  end

  def rating
    return "No rating" if @response.nil?
    rating_element = @response.css("a.a-popover-trigger.a-declarative span.a-size-base.a-color-base").first
    @rating ||= rating_element&.text&.strip || "No rating"
  end

  def reviews
    return "No reviews" if @response.nil?
    reviews = @response.css("span#acrCustomerReviewText").first&.text&.strip
    @reviews ||= reviews.nil? ? "No reviews" : reviews.split(" ")[0]
  end


end