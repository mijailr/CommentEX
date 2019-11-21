defmodule Comment.Factory do
  use ExMachina.Ecto, repo: Comment.Repo

  import Comment.Factory.Installation
end
