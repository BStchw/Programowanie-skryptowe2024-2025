## Amazon Web Crawler

Projekt wykorzystuje Ruby i gem nokogiri do pobierania informacji o produktach z Amazonu. Skrypt pozwala na pobieranie tytułu produktu, jego ceny, oceny oraz liczby opinii z podanego URL-a produktu. Program pomija produkty sponsorowane, gdyż maja one inny układ HTML niż zwykłe produkty.

### Wymagania
- Ruby 3.+
- Gems: nokogiri, open-uri, net/http

### Instalacja

Zainstaluj zależności: Skorzystaj z poniższego polecenia, aby zainstalować niezbędne gemy:

`bundle install`

### Użycie
Możesz uruchomić skrypt za pomocą polecenia:

`ruby crawl.rb`


