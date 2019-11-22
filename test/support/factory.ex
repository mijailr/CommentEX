defmodule Comment.Factory do
  @moduledoc """
  The factories for the models in the application
  """
  use ExMachina.Ecto, repo: Comment.Repo
  alias Comment.Factory.{Installation, Repository}

  use Installation
  use Repository
end
