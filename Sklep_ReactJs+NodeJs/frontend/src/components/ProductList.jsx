import React from 'react';
import { useParams } from 'react-router-dom';

function ProductList({ products, categories }) {
    const { categoryId } = useParams(); // Pobieramy ID kategorii z URL-a
    const category = categories?.find(cat => cat.id === Number(categoryId));

    // Jeśli categoryId istnieje, filtrujemy produkty dla tej kategorii
    const filteredProducts = categoryId
        ? products.filter(product => product.category === Number(categoryId))
        : products; // Jeśli nie, pokazujemy wszystkie produkty

    return (
        <div>
            {/* Jeśli jesteśmy na stronie kategorii, pokazujemy jej nazwę */}
            {categoryId && <h2>Produkty w kategorii: {category?.name || 'Nieznana kategoria'}</h2>}

            {/* Jeśli lista produktów jest pusta, wyświetlamy komunikat */}
            {filteredProducts.length === 0 ? (
                <p>Brak produktów w tej kategorii.</p>
            ) : (
                <div className="product-list">
                    {filteredProducts.map(product => (
                        <div className="product-item" key={product.id}>
                            <h3>{product.name}</h3>
                            <img src={product.image} alt={product.name} />
                            <p>{product.description}</p>
                            <p>Cena: {product.price} zł</p>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}

export default ProductList;
