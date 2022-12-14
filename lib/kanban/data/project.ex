defmodule Kanban.Data.Project do
  use Ecto.Schema

  import Ecto.Changeset

  # alias Kanban.Data.{Task}

  @primary_key false
  embedded_schema do
    # field :id, :binary_id, autogenerate: &Ecto.UUID.generate/0
    field :title, :string
    field :description, :string
    # has_many :tasks, Task
  end

  def changeset(project, params) do
    project
    |> cast(params, ~w[title description]a)
    # |> cast_assoc(:tasks, with: &Task.changeset/2)
    |> validate_required(~w[title]a)
  end
end
