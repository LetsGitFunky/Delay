module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :user, Types::UserType, null: false do
      description "Find a user by ID"
      argument :id, ID, required: true
    end

    field :product, Types::ProductType, null: true do
      description "Find a product by ID"
      argument :id, ID, required: true
    end

    field :products, [Types::ProductType], null: false do
      description "Get all products"
    end

    def user(id:)
      User.find_by(id: id)
    end

    def product(id:)
      Product.find_by(id: id)
    end

    def products
      Product.all
    end
  end
end
