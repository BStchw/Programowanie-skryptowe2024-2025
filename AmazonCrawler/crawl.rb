require_relative 'amazon_category'
require_relative 'amazon'

category_url = "https://www.amazon.com/s?k=headphones&crid=1J57V157GW7D1&sprefix=headphones%2Caps%2C630&ref=nb_sb_noss_1"

begin
  category = AmazonCategory.new(category_url)
  product_urls = category.product_links

  product_urls.each do |url|
    product = Amazon.new(url)
    puts "--------------------------"
    puts "Title:    #{product.title}"
    puts "Rate:   #{product.rating}"
    puts "Number of ratings: #{product.reviews}"
    puts "Price:    #{product.price}"
  end
rescue StandardError => e
  puts "Błąd pobierania danych z kategorii: #{e.message}"
end
