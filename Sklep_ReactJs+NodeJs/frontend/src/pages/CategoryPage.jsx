import React from "react";
import { useParams, Link } from "react-router-dom";

const CategoryPage = ({ products, categories }) => {
    const { categoryId } = useParams();
    const category = categories.find((c) => c.id === parseInt(categoryId));
    const filteredProducts = products.filter((p) => p.category === parseInt(categoryId));

    return (
        <div>
            <h2 className="text-2xl font-bold mb-4">
                {category ? category.name : "Nieznana kategoria"}
            </h2>
            <Link to="/" className="text-blue-500 hover:underline">⬅ Powrót do sklepu</Link>
            <ul className="mt-4">
                {filteredProducts.map((prod) => (
                    <li key={prod.id} className="border p-2 my-2 rounded-lg shadow">
                        {prod.name}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default CategoryPage;
