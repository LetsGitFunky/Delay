module Mutations
    class CreateProduct < Mutations::BaseMutation
        argument :name, String, required: true
        argument :description, String, required: true
        argument :price, Integer, required: true
        argument :user_id, ID, required: true

        field :product, Types::ProductType, null: false
        field :errors, [String], null: false

        def resolve(name:, description:, price:, user_id:)
            user = User.find(user_id)
            product = user.products.build(name: name, description: description, price: price)
            if product.save
                {
                    product: product,
                    errors: []
                }
            else
                {
                    product: nil,
                    errors: product.errors.full_messages
                }
            end
        end
    end
end
