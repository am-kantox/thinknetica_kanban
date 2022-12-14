defmodule Kanban.Data.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Kanban.Data.{Task, User}

  @primary_key false
  embedded_schema do
    # field :id, :binary_id, autogenerate: &Ecto.UUID.generate/0
    field :name, :string
    field :password, :string, redact: true
    embeds_many :tasks, Task
  end

  def changeset(user, params) do
    user
    |> cast(params, ~w[name password]a)
    |> cast_embed(:tasks, with: &Task.changeset/2)
    |> validate_required(~w[name]a)
  end

  def create(params) when is_list(params),
    do: params |> Map.new() |> create()

  def create(params) when is_map(params) do
    %User{}
    |> changeset(params)
    |> case do
      %Ecto.Changeset{valid?: false, errors: errors} -> {:error, errors}
      changeset -> apply_changes(changeset)
    end
  end

  def create_default do
    create(
      name: "am",
      password: "pwd",
      tasks: [
        %{
          title: "Task1",
          due: DateTime.add(DateTime.utc_now(), 5, :day),
          project: %{title: "Project1"}
        }
      ]
    )
  end
end
