defmodule Comment.GithubTest do
  use ExUnit.Case

  alias Comment.Github

  doctest Github

  setup_all do
    Application.put_env(:comment, :github, [
      {:secret_key, "123"}
    ])
  end

  test "calculate good signature" do
    payload =
      Github.handle_payload(
        "hello world!",
        "sha1=d3e220f8e2233a1951ab9e30dba562f1e388f369"
      )

    assert payload == {:ok, "hello world!"}
  end

  test "calculate bad signature" do
    payload =
      Github.handle_payload(
        "hello world!",
        "sha256=bee0f432b504b5f2bd795554e95606a17fee40b07f108463aeabc8d169b1a7f1"
      )

    assert {:error, "not the same digest"} == payload
  end
end
