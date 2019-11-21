defmodule Comment.Github.Tokens do
  use Joken.Config, default_signer: :github

  @impl true
  def token_config do
    token_settings = [
      default_exp: 600,
      iss: Application.fetch_env!(:comment, :github_app_id)
    ]

    default_claims(token_settings)
  end
end
