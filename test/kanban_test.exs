defmodule KanbanTest do
  use ExUnit.Case
  doctest Kanban

  test "greets the world" do
    assert Kanban.hello(true) == :world
    assert Kanban.hello(false) == :sun
  end
end
