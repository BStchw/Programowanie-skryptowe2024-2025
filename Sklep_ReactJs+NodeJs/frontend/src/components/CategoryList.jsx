import React from 'react';
import { Link } from 'react-router-dom';

function CategoryList({ categories }) {
    return (
        <div className="category-list">
            {categories.map((category) => (
                <Link to={`/category/${category.id}`} key={category.id}>
                    <div className="category-item">
                        {category.name}
                    </div>
                </Link>
            ))}
        </div>
    );
}

export default CategoryList;
