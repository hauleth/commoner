defmodule CommonTest.Suite do
  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: [test: 2, test: 3]
      import CommonTest.Assertions

      Module.register_attribute(__MODULE__, :common_test_tests, accumulate: true)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro test(message, var \\ quote(do: _), contents) do
    contents =
      case contents do
        [do: block] ->
          quote do
            unquote(block)
            :ok
          end

        _ ->
          quote do
            try(unquote(contents))
            :ok
          end
      end

    var = Macro.escape(var)
    contents = Macro.escape(contents, unquote: true)

    quote bind_quoted: [var: var, contents: contents, message: message] do
      name = :"#{message}"
      @common_test_tests name
      def unquote(name)(unquote(var)), do: unquote(contents)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def all, do: @common_test_tests
    end
  end
end
