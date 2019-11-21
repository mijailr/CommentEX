defmodule Comment.Factory do
  @moduledoc """
  The factories for the models in the application
  """
  use ExMachina.Ecto, repo: Comment.Repo

  use Comment.Factory.Installation
end
