import Config

config :comment,
  github_secret_key: "dummysecretkey",
  github_app_id: "000000",
  port: 3000,
  ecto_repos: [Comment.Repo]

config :joken,
  github: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN RSA PRIVATE KEY-----
    MIICXQIBAAKBgQDy2ofn3qGrL2Iu2Ovu96+ECgSiuZDM/l5z8hxc5IVXdrCr3xQt
    ftG589mpkZj5m/ojefiFrDahNOWQuy4dAUSJmU49jWrfLuc9MhGC50sHeEdUu/OB
    tnY4mqD76ELdxGnOh+z3LxunVrV27/LrGnFDS4plcaZQp2WQqFyQfI3fBwIDAQAB
    AoGAQcctHoGvumU4K8Y3iV9vG8122fh3Hv8a6D7Arex7rWgJjFP87CG4fqxs3UAB
    dkJoKynDRbmShnGEaII6iEKqpC9THloVO5DEcmayNBRX9XYnveMGWN27ZGU0nKo9
    ziYfRTmYpdeA5HF/wX/HUa36wZVi4WNmed6OFsdD4jvYelECQQD/2B+77r1ybk3y
    GAtmZWSMWeWdpwp0mk367QaqVrS4Orr1fHNmWDirbJ3e6UbVZpq7Dr9qadb+oCa0
    wmsXc/SpAkEA8wBh17iXvBjl2/rec8mAoAXkh2pOU8gSA+8PYEwPJbCbe/jou+6R
    hU8t2BpzZ5NL0PSxfU8PmfmdnpdIi2jULwJBALQcOVL7YmFBqBvrs3LVpHBuBQj0
    hJbL3mPtI4kdW0JrDh0uDKubJeIAqC86eIRZJErVugm3EwTUSAtu5ydumWkCQDHR
    lj2fvpv1jsp2uDyMxy4Hhz6r8LsEfY0I6eIYNdLITlgwQ6aj1nm6Le/sHFTTweto
    /yptlwk+P65P3bOXHkkCQQDRv63oEmiPFKXmFDg/q5RMwc70C3jSkUe0FsHxMzbj
    cTBmao7M8iOrHl+ZdQewkVLS3WlE2CUsLzsWs+jQ9RQy
    -----END RSA PRIVATE KEY-----
    """
  ]

config :tentacat,
  deserialization_options: [],
  extra_headers: [
    {"Accept", "application/vnd.github.machine-man-preview+json"}
  ],
  pagination: [],
  request_options: []

import_config("#{Mix.env()}.exs")
