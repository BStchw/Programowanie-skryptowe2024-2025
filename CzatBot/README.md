# Restaurany chatbot

Jest to bot do asysty w restauracji, który wykorzystuje framework Rasa. Bot umożliwia wyświetlanie menu, sprawdzanie godzin otwarcia, składanie zamówień oraz interakcję z użytkownikiem.


## Instalacja
- Krok 1: Instalacja Rasa
    - Zainstaluj Python 3.8 lub nowszy (jeśli jeszcze tego nie zrobiłeś) z oficjalnej strony Pythona.

    - Stwórz i aktywuj wirtualne środowisko (zalecane):

    - W terminalu, w katalogu projektu, uruchom:

        `python -m venv rasa_env`

    - Aktywuj wirtualne środowisko:

        Na Windows:
          `rasa_env\Scripts\activate`

  - Zainstaluj Rasa i wymagane zależności:

     - W katalogu projektu, zainstaluj Rasa:
        
            `pip install rasa`

    
- Krok 2: Trening modelu

    Aby bot mógł odpowiednio reagować, musisz go wytrenować.

    - Trenuj model: W terminalu, w katalogu projektu, uruchom:

        `rasa train`

    - Po zakończeniu procesu treningu, model będzie zapisany w folderze models.

- Krok 3: Uruchomienie lokalnie

Zanim połączysz bota z Slackiem, możesz go przetestować lokalnie.

Uruchom serwer akcji: Bot używa serwera do obsługi niestandardowych akcji (np. action_introduce_bot, action_check_opening_hours), więc uruchom go osobno:

`rasa run actions`

Uruchom Rasa Shell (lokalne testowanie bota): W terminalu uruchom:

`rasa shell`


Krok 4: Konfiguracja Slacka
1. Stwórz aplikację na Slacku
2. Skonfiguruj uprawnienia i webhook.

Skopiuj Bot User OAuth Token i Signing Secret. Te tokeny będą potrzebne do konfiguracji bota w Rasa!!!

Uruchamiając bota na slacku:
1. Uruchom serwer akcji:

    `rasa run actions`

2. Uruchom główny serwer:

    `rasa run --enable-api --connector slack`

3. Możesz korzystać z bota w aplikacji (jeśli wcześniej prawidłowo ją skonfigurowałeś).