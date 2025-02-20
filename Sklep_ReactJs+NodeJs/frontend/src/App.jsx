import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import './App.css';
import CategoryList from './components/CategoryList';
import ProductList from './components/ProductList';

function App() {
    const [categories, setCategories] = useState([]);
    const [products, setProducts] = useState([]);

    useEffect(() => {
        fetch('http://localhost:5000/categories')
            .then(res => res.json())
            .then(data => setCategories(data));

        fetch('http://localhost:5000/products')
            .then(res => res.json())
            .then(data => setProducts(data));
    }, []);

    return (
        <Router>
            <div>
                <h1>Internetowy Sklep Wielobranżowy SZARYKOT</h1>

                <Routes>
                    <Route
                        path="/"
                        element={
                            <div>
                                {/* Lista kategorii */}
                                <CategoryList categories={categories} />

                                {/* Wszystkie produkty */}
                                <h2>Wszystkie produkty</h2>
                                <ProductList products={products} />
                            </div>
                        }
                    />

                    {/* Strona z produktami dla konkretnej kategorii */}
                    <Route
                        path="/category/:categoryId"
                        element={<ProductList products={products} categories={categories} />}
                    />
                </Routes>
            </div>
        </Router>
    );
}

export default App;
