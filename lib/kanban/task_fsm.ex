defmodule Kanban.TaskFSM do
  @moduledoc """
  Process to be run
  """

  alias Kanban.Data.Task

  use GenServer

  def start_link(%Task{state: :idle} = task) do
    GenServer.start_link(__MODULE__, task, name: __MODULE__)
  end

  def start(pid \\ __MODULE__) do
    GenServer.call(pid, {:transition, :start})
  end

  def finish(pid \\ __MODULE__) do
    GenServer.call(pid, {:transition, :finish})
  end

  @impl GenServer
  def init(state), do: {:ok, state}

  @impl GenServer
  def handle_call(:state, _from, %Task{state: state} = task) do
    {:reply, state, task}
  end

  @impl GenServer
  def handle_cast({:transition, :start}, %Task{state: :idle} = task) do
    new_task =
      case Task.update(task) do
        :ok -> %Task{task | state: :doing}
        :error -> task
      end

    {:noreply, new_task}
  end

  @impl GenServer
  def handle_call({:transition, :finish}, _from, %Task{state: :doing} = task) do
    # Save to external storage
    {:stop, :normal, :ok, %Task{task | state: :done}}
  end

  @impl GenServer
  def handle_call({:transition, transition}, _from, %Task{state: state} = task) do
    {:reply, {:error, {:not_allowed, transition, state}}, task}
  end
end
