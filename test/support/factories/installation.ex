defmodule Comment.Factory.Installation do
  use ExMachina.Ecto, repo: Comment.Repo

  def installation_factory do
    %Comment.Installation{
      account_login: Faker.Internet.user_name(),
      account_type: "User",
      account_id: Faker.random_between(0, 99999),
      installation_id: Faker.random_between(0, 99999)
    }
  end
end
