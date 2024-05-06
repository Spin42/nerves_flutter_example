defmodule NervesFlutterExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NervesFlutterExample.Supervisor]

    Process.sleep(10_000)
    children =
      [
        # Children for all targets
        # Starts a worker by calling: NervesFlutterExample.Worker.start_link(arg)
        # {NervesFlutterExample.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: NervesFlutterExample.Worker.start_link(arg)
      # {NervesFlutterExample.Worker, arg},
    ]
  end

  def children(_target) do
    [
      {NervesFlutterpi,
        flutter_app_dir: "/var/flutter_assets",
        name: :flutterpi}
      # Children for all targets except host
      # Starts a worker by calling: NervesFlutterExample.Worker.start_link(arg)
      # {NervesFlutterExample.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:nerves_flutter_example, :target)
  end
end
