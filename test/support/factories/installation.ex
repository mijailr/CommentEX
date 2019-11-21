defmodule Comment.Factory.Installation do
  @moduledoc """
  Define a installation factory to be used inside the
  Comment.Factory module
  """
  defmacro __using__(_) do
    quote do
      def installation_factory do
        %Comment.Installation{
          account_login: Faker.Internet.user_name(),
          account_type: "User",
          account_id: Faker.random_between(0, 99_999),
          installation_id: Faker.random_between(0, 99_999)
        }
      end
    end
  end
end
