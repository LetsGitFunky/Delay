import { gql } from '@apollo/client';

const GET_PRODUCTS = gql`
    query GetProducts {
        products {
        id
        name
        description
        price
        }
    }
`;

export default GET_PRODUCTS;
