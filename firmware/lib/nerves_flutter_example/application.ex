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
    :ok = setup_db!()
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
        name: :flutterpi},
      # Children for all targets except host
      # Starts a worker by calling: NervesFlutterExample.Worker.start_link(arg)
      # {NervesFlutterExample.Worker, arg},
    ]
  end

  defp setup_db! do
    repos = Application.get_env(:backend, :ecto_repos)
    for repo <- repos do
      if Application.get_env(:backend, repo)[:adapter] == Ecto.Adapters.SQLite3 do
        setup_repo!(repo)
        migrate_repo!(repo)
      end
    end
    :ok
  end

  defp setup_repo!(repo) do
    db_file = Application.get_env(:backend, repo)[:database]
    unless File.exists?(db_file) do
      :ok = repo.__adapter__.storage_up(repo.config)
    end
  end

  defp migrate_repo!(repo) do
    opts = [all: true]
    migrator = &Ecto.Migrator.run/4
    migrations_path = Path.join([:code.priv_dir(:backend) |> to_string, "repo", "migrations"])
    migrator.(repo, migrations_path, :up, opts)
  end

  def target() do
    Application.get_env(:nerves_flutter_example, :target)
  end
end
