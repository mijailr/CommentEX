# Allow skip tests
ExUnit.configure(exclude: [skip: true])

{:ok, _} = Application.ensure_all_started(:ex_machina)
Ecto.Adapters.SQL.Sandbox.mode(Comment.Repo, :manual)

ExUnit.start()
Faker.start()
