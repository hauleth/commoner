defmodule Commoner.Hooks.Shell do
  def init(_id, _opts) do
    {:ok, nil}
  end

  def post_end_per_testcase(_suite, _testcase, _config, :ok, state) do
    write([:green, ?.])
    {:ok, state}
  end

  def post_end_per_testcase(_suite, _testcase, _config, return, state) do
    write([:red, ?F])
    {return, state}
  end

  def on_tc_fail(suite, name, {%ExUnit.AssertionError{} = error, _}, state) do
    write(Exception.message(error))

    :ct.log(:error, 100, Exception.message(error))

    state
  end

  def on_tc_fail(_, _, _, state) do
    state
  end

  defp write(message), do: IO.write(:user, IO.ANSI.format(message))
end
