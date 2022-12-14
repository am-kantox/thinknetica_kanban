defmodule Kanban.Data.Task do
  use Ecto.Schema

  # alias Kanban.Data.{Project, User}
  alias Kanban.Data.Project

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    # field :id, :binary_id, autogenerate: &Ecto.UUID.generate/0
    field :title, :string
    field :description, :string
    field :state, :string
    field :time_spent, :integer, default: 0
    field :due, :utc_datetime
    embeds_one :project, Project
    # belongs_to :user, User
    # belongs_to :project, Project
  end

  def changeset(task, params) do
    task
    |> cast(params, ~w[title description due]a)
    |> cast_embed(:project, with: &Project.changeset/2)
    |> validate_required(~w[title due]a)
    |> validate_inclusion(:state, ~w[idle doing done]a)
  end
end
