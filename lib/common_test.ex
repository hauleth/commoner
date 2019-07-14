defmodule CommonTest do
  @default_importance 50

  for name <- ~w[log print pal]a do
    def unquote(name)(format), do: unquote(name)(:default, @default_importance, format, [], [])

    def unquote(name)(x1, x2) do
      {category, importance, format, args} =
        cond do
          is_atom(x1) -> {x1, @default_importance, x2, []}
          is_integer(x1) -> {:default, x1, x2, []}
          true -> {:default, @default_importance, x1, x2}
        end

      unquote(name)(category, importance, format, args, [])
    end

    def unquote(name)(x1, x2, x3) do
      {category, importance, format, args, opts} =
        cond do
          is_atom(x1) and is_integer(x2) -> {x1, x2, x3, [], []}
          is_atom(x1) -> {x1, @default_importance, x2, x3, []}
          is_integer(x1) -> {:default, x1, x2, x3, []}
          true -> {:default, @default_importance, x1, x2, x3}
        end

      unquote(name)(category, importance, format, args, opts)
    end

    def unquote(name)(x1, x2, x3, x4) do
      {category, importance, format, args, opts} =
        cond do
          is_atom(x1) and is_integer(x2) -> {x1, x2, x3, x4, []}
          is_atom(x1) -> {x1, @default_importance, x2, x3, x4}
          is_integer(x1) -> {:default, x1, x2, x3, x4}
        end

      unquote(name)(category, importance, format, args, opts)
    end

    def unquote(name)(category, importance, format, args, opts) do
      :ct.unquote(name)(category, importance, to_charlist(format), args, opts)
    end
  end

  defdelegate fail(reason), to: :ct

  def fail(format, args) do
    :ct.fail(to_charlist(format), args)
  end
end
