defmodule Felix.Application do
  @moduledoc false

  use Application

  alias Felix.{Config, Router}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = Config.port(Mix.env)
    children = [
      Plug.Adapters.Cowboy.child_spec(
        :http, Router, [], [port: port]
      )
    ]

    opts = [strategy: :one_for_one, name: Felix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
