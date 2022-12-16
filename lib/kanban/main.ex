defmodule Kanban.Main do
  # Automatically defines child_spec/1
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      Kanban.State,
      Kanban.TaskManager
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
