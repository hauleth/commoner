defmodule Mix.Tasks.CommonTest do
  use Mix.Task

  def run(_args) do
    Mix.Task.run(:loadpaths)

    path = "common_test"

    Application.put_env(:common_test, :auto_compile, false)

    match = Path.join([path, "**", "*_suite.exs"])

    modules =
      for file <- Path.wildcard(match),
          {module, _} <- Code.require_file(file),
          do: module

    IO.inspect(
      :ct.run_testspec([
        {:suites, to_charlist(path), modules},
        logdir: './results',
        abort_if_missing_suites: true,
        ct_hooks: [Commoner.Hooks.Shell]
      ])
    )
  end
end
