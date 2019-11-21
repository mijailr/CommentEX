defmodule Comment.GithubTest do
  use ExUnit.Case

  alias Comment.Github

  doctest Github

  setup_all do
    Application.put_env(:comment, :github, [
      {:secret_key, "123"}
    ])
  end

  test "check good signature" do
    payload =
      Github.verify_signature(
        "hello world!",
        "sha1=a4e4e63faa4741c471b5e4fc0284feb41c085ac7"
      )

    assert payload == {:ok, "hello world!"}
  end

  test "check bad signature" do
    payload =
      Github.verify_signature(
        "hello world!",
        "sha256=bee0f432b504b5f2bd795554e95606a17fee40b07f108463aeabc8d169b1a7f1"
      )

    assert {:error, "not the same digest"} == payload
  end
end
