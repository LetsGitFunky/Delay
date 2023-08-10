module Mutations
    class UpdateProduct < Mutations::BaseMutation
        argument :id, ID, required: true
        argument :user_id, ID, required: true
        argument :name, String, required: false
        argument :description, String, required: false
        argument :price, Integer, required: false

        field :product, Types::ProductType, null: true
        field :errors, [String], null: false

        def resolve(id:, user_id:, name: nil, description: nil, price: nil)
            product = Product.find_by(id: id, user_id: user_id)

            if product.nil?
                return {
                    product: nil,
                    errors: ["Product not found or unauthorized"]
                }
            end

            if product.update(name: name, description: description, price: price)
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
