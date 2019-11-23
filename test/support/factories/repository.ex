defmodule Comment.Factory.Repository do
  @moduledoc """
  Define a repository factory to be used inside the
  Comment.Factory module
  """
  defmacro __using__(_) do
    quote do
      def repository_factory do
        name = Faker.Internet.user_name()
        full_name = "#{name}/#{Faker.Internet.user_name()}"

        %Comment.Repository{
          name: name,
          full_name: full_name,
          private: false,
          repository: Faker.random_between(0, 99_999),
          installation_id: nil
        }
      end
    end
  end
end
