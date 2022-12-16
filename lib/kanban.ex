defmodule Kanban do
  @moduledoc """
  Documentation for `Kanban`.
  """

  def start_task(task_id) do
    Kanban.TaskFSM.start({:via, Registry, {Kanban.TaskRegistry, task_id}})
  end

  def finish_task(task_id) do
    Kanban.TaskFSM.finish({:via, Registry, {Kanban.TaskRegistry, task_id}})
  end

  def query_task(task_id) do
    # if Process.alive?({:via, Registry, {Kanban.TaskRegistry, task_id}}) do
    Kanban.TaskFSM.state({:via, Registry, {Kanban.TaskRegistry, task_id}})
    # end
  end
end
