defmodule Haphx.Exam.Problem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Haphx.Exam.Problem


  schema "problems" do
    field :body, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Problem{} = problem, attrs) do
    problem
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
