require "nokogiri"
require "open-uri"
require "uri"
require "net/http"

class AmazonCategory
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
      else
        raise "HTTP error: #{response.code}"
      end
    rescue StandardError => e
      puts "Błąd: #{e.message}"
      nil
    end
  end

  def product_links
    return [] unless @response

    links = @response.css("div.s-main-slot div[data-component-type='s-search-result']").reject do |product|
      # Ignorujemy "Featured from Amazon brands"
      product.at_css("span.a-size-micro.a-color-secondary")&.text&.include?("Featured from Amazon brands") ||

        # Ignorujemy produkty oznaczone jako "Sponsored"
        product.at_css("span.a-color-secondary")&.text&.include?("Sponsored")
    end

    links.map { |product|
      link = product.at_css("a.a-link-normal.s-no-outline")&.[]("href")
      "https://www.amazon.com#{link}" if link
    }.compact.uniq
  end


end
