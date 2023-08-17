import React from 'react';
import { useQuery } from '@apollo/client';
import GET_PRODUCTS from './src/queries/getProducts';

const ProductList = () => {
    const { loading, error, data } = useQuery(GET_PRODUCTS);

    if (loading) return <Text>Loading...</Text>;
    if (error) return <Text>Error: {error.message}</Text>;

    return (
        <View>
        {data.products.map(product => (
            <Text key={product.id}>{product.name}</Text>
        ))}
        </View>
    );
};

export default ProductList;
