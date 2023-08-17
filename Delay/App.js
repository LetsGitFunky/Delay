import React from 'react';
import { ApolloProvider } from '@apollo/client';
import client from './src/apollo';

const App = () => {
    return (
        <ApolloProvider client={client}>
        {/* Rest of your app components */}
        </ApolloProvider>
    );
};

export default App;
