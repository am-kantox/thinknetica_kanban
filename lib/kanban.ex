defmodule Kanban do
  @moduledoc """
  Documentation for `Kanban`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Kanban.hello(true)
      :world
      iex> Kanban.hello(false)
      :sun

  """
  def hello(arg) do
    case arg do
      true -> :world
      false -> :sun
    end
  end
end
