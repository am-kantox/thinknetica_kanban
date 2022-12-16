defmodule Kanban.TaskManager do
  @moduledoc """
  The supervisor for all the task processes/fsms.
  """
  use DynamicSupervisor

  alias Kanban.Data.Task

  def start_link(init_arg \\ []),
    do: DynamicSupervisor.start_link(__MODULE__, init_arg, name: Kanban.TaskManager)

  @impl true
  def init(_init_arg),
    do: DynamicSupervisor.init(strategy: :one_for_one)

  @doc """
  Starts the task process under this module supervision.
  """
  @spec start_task(Task.t()) :: pid()
  def start_task(%Task{} = task) do
    Kanban.TaskManager
    |> DynamicSupervisor.start_child({Kanban.TaskFSM, task: task})
    |> case do
      {:ok, pid} ->
        Kanban.State.put(task.title, task.state)
        pid

      {:error, {:already_started, pid}} ->
        pid
    end
  end

  @spec start_task(String.t(), pos_integer(), String.t()) :: pid()
  def start_task(title, due_days, project_title) do
    Task.create(title, due_days, project_title)
    |> start_task()
  end
end
