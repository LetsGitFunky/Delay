module Mutations
    class CreateUser < Mutations::BaseMutation
        argument :username, String, required: true
        argument :email, String, required: true
        argument :password, String, required: true

        field :user, Types::UserType, null: false
        field :errors, [String], null: false

        def resolve(username:, email:, password:)
            user = User.new(username: username, email: email, password: password)
            if user.save
                {
                    user: user,
                    errors: []
                }
            else
                {
                    user: nil,
                    errors: user.errors.full_messages
                }
            end
        end
    end

    class UpdateUser < Mutations::BaseMutation
        argument :id, ID, required: true
        argument :username, String, required: false
        argument :email, String, required: false
        argument :password, String, required: false

        field :user, Types::UserType, null: false
        field :errors, [String], null: false

        def resolve(id:, username: nil, email: nil, password: nil)
            user = User.find_by(id: id)

            update_params = {}
            update_params[:username] = username if username
            update_params[:email] = email if email
            update_params[:password] = password if password


            if user.nil?
                {
                    user: nil,
                    errors: ["User not found"]
                }
            elsif user.update(update_params)
                {
                    user: user,
                    errors: []
                }
            else
                {
                    user: nil,
                    errors: user.errors.full_messages
                }
            end
        end
    end

    class Login < Mutations::BaseMutation
        argument :email, String, required: true
        argument :password, String, required: true

        field :user, Types::UserType, null: false
        field :token, String, null: false

        def resolve(email:, password:)
            user = User.find_by_credentials(email, password)
            if user
                token = user.reset_session_token! # Or however you want to handle tokens
                { user: user, token: token }
            else
            # Handle error
            end
        end
    end

end
