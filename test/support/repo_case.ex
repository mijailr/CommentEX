defmodule Comment.RepoCase do
  @moduledoc """
  This module set the test cases for use Ecto
  """
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias Comment.Repo

      import Ecto
      import Ecto.Query

      import Comment.RepoCase
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Repo)

    unless tags[:async] do
      Sandbox.mode(Repo, {:shared, self()})
    end

    :ok
  end
end
