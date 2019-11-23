defmodule Comment.CryptoTest do
  use ExUnit.Case
  import Comment.Crypto

  alias Comment.Crypto

  doctest Crypto

  @key Application.fetch_env!(:comment, :github_secret_key)
  @files Path.wildcard("test/fixtures/webhook/*.json")

  for file <- @files do
    @payload File.read!(file)
    @signature File.read!("#{file}.sig") |> String.replace("\n", "")

    test "calculate_signature of #{file}" do
      assert calculate_signature(@key, @payload) == @signature
    end
  end
end
