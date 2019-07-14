defmodule CommonTest.Assertions do
  @falsey [nil, false]

  def assert(val, message) when val in @falsey, do: CommonTest.fail(message)
  def assert(_, _message), do: :ok

  def assert(val, _success, failure) when val in @falsey do
    CommonTest.fail(failure)
  end

  def assert(_, success, _failure) do
    CommonTest.log(to_string(success))

    :ok
  end

  defmacro assert({:=, _, [a, b]} = match) do
    quote do
      case unquote(b) do
        unquote(a) = val ->
          CommonTest.log(
            "~s matched ~s",
            [unquote(Macro.to_string(b)), unquote(Macro.to_string(a))]
          )

        _ ->
          CommonTest.fail({:unmatched, unquote(Macro.escape(a)), unquote(Macro.escape(b))})
      end
    end
  end

  defmacro assert(expr) do
    quote do
      unquote(__MODULE__).assert(
        unquote(expr),
        unquote("Passed #{Macro.to_string(expr)}"),
        unquote("Failed #{Macro.to_string(expr)}")
      )
    end
  end
end
