module Mutations
    class Login < Mutations::BaseMutation
        argument :email, String, required: true
        argument :password, String, required: true

        field :user, Types::UserType, null: true
        field :token, String, null: true
        field :errors, [String], null: false

        def resolve(email:, password:)
            user = User.find_by_credentials(email, password)
            if user
                token = user.reset_session_token!
                { user: user, token: token, errors: [] }
            else
                { user: nil, token: nil, errors: ["Invalid email or password"] }
            end
        end
    end
end
