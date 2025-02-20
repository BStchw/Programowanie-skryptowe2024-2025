const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

let categories = [
    { id: 1, name: 'Elektronika' },
    { id: 2, name: 'Odzież' },
    { id: 3, name: 'Książki' },
    { id: 4, name: 'AGD' },
    { id: 5, name: 'Zabawki' }
];

//Zdjecia są tylko poglądowe!!!
let products = [
    // Elektronika
    { id: 1, name: 'Laptop', category: 1, price: 3000, description: 'Wysokiej jakości laptop', image: 'http://localhost:5000/images/kot.png' },
    { id: 2, name: 'Smartfon', category: 1, price: 2500, description: 'Nowoczesny smartfon z dużym ekranem', image: 'http://localhost:5000/images/kot.png' },
    { id: 3, name: 'Słuchawki', category: 1, price: 200, description: 'Bezprzewodowe słuchawki douszne', image: 'http://localhost:5000/images/kot.png' },
    { id: 4, name: 'Tablet', category: 1, price: 1500, description: 'Poręczny tablet z ekranem 10 cali', image: 'http://localhost:5000/images/kot.png' },
    { id: 5, name: 'Smartwatch', category: 1, price: 800, description: 'Inteligentny zegarek z pulsometrem', image: 'http://localhost:5000/images/kot.png' },

    // Odzież
    { id: 6, name: 'Koszulka', category: 2, price: 50, description: 'Koszulka bawełniana', image: 'http://localhost:5000/images/kot.png' },
    { id: 7, name: 'Jeansy', category: 2, price: 120, description: 'Wygodne spodnie jeansowe', image: 'http://localhost:5000/images/kot.png' },
    { id: 8, name: 'Kurtka', category: 2, price: 300, description: 'Zimowa kurtka z kapturem', image: 'http://localhost:5000/images/kot.png' },
    { id: 9, name: 'Buty sportowe', category: 2, price: 250, description: 'Lekkie buty do biegania', image: 'http://localhost:5000/images/kot.png' },
    { id: 10, name: 'Czapka', category: 2, price: 40, description: 'Ciepła czapka zimowa', image: 'http://localhost:5000/images/kot.png' },

    // Książki
    { id: 11, name: 'Władca Pierścieni', category: 3, price: 80, description: 'Klasyczna powieść fantasy', image: 'http://localhost:5000/images/kot.png' },
    { id: 12, name: 'Harry Potter', category: 3, price: 70, description: 'Przygody młodego czarodzieja', image: 'http://localhost:5000/images/kot.png' },
    { id: 13, name: 'Duma i uprzedzenie', category: 3, price: 60, description: 'Klasyczna powieść romantyczna', image: 'http://localhost:5000/images/kot.png' },
    { id: 14, name: 'Kod Leonarda da Vinci', category: 3, price: 90, description: 'Thriller Dana Browna', image: 'http://localhost:5000/images/kot.png' },
    { id: 15, name: 'Hobbit', category: 3, price: 85, description: 'Przygody Bilbo Bagginsa', image: 'http://localhost:5000/images/kot.png' },

    // AGD
    { id: 16, name: 'Lodówka', category: 4, price: 2500, description: 'Nowoczesna lodówka z zamrażarką', image: 'http://localhost:5000/images/kot.png' },
    { id: 17, name: 'Pralka', category: 4, price: 1800, description: 'Pralka automatyczna z dużym bębnem', image: 'http://localhost:5000/images/kot.png' },
    { id: 18, name: 'Mikrofalówka', category: 4, price: 600, description: 'Kompaktowa mikrofalówka do kuchni', image: 'http://localhost:5000/images/kot.png' },
    { id: 19, name: 'Ekspres do kawy', category: 4, price: 700, description: 'Automatyczny ekspres do kawy', image: 'http://localhost:5000/images/kot.png' },
    { id: 20, name: 'Odkurzacz', category: 4, price: 500, description: 'Bezprzewodowy odkurzacz pionowy', image: 'http://localhost:5000/images/kot.png' },

    // Zabawki
    { id: 21, name: 'Klocki LEGO', category: 5, price: 200, description: 'Zestaw kreatywnych klocków', image: 'http://localhost:5000/images/kot.png' },
    { id: 22, name: 'Lalka Barbie', category: 5, price: 80, description: 'Klasyczna lalka Barbie', image: 'http://localhost:5000/images/kot.png' },
    { id: 23, name: 'Samochód zdalnie sterowany', category: 5, price: 150, description: 'Wyścigowy samochód RC', image: 'http://localhost:5000/images/kot.png' },
    { id: 24, name: 'Puzzle 1000 elementów', category: 5, price: 50, description: 'Układanka 1000 elementów', image: 'http://localhost:5000/images/kot.png' },
    { id: 25, name: 'Pluszowy miś', category: 5, price: 60, description: 'Miękki pluszowy miś', image: 'http://localhost:5000/images/kot.png' }
];





// Pobierz wszystkie kategorie
app.use('/images', express.static('images'));
app.get('/categories', (req, res) => {
    res.json(categories);
});

// Pobierz wszystkie produkty
app.use('/images', express.static('images'));
app.get('/products', (req, res) => {
    res.json(products);
});

// Uruchom serwer
app.listen(5000, () => console.log('Server running on port 5000'));