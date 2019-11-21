defmodule Comment.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Comment.Repo

      import Ecto
      import Ecto.Query

      import Comment.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Comment.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Comment.Repo, {:shared, self()})
    end

    :ok
  end
end
