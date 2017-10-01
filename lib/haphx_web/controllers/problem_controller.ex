defmodule HaphxWeb.ProblemController do
  use HaphxWeb, :controller

  alias Haphx.Exam
  alias Haphx.Exam.Problem

  def index(conn, _params) do
    problems = Exam.list_problems()
    render(conn, "index.html", problems: problems)
  end

  def new(conn, _params) do
    changeset = Exam.change_problem(%Problem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"problem" => problem_params}) do
    case Exam.create_problem(problem_params) do
      {:ok, problem} ->
        conn
        |> put_flash(:info, "Problem created successfully.")
        |> redirect(to: problem_path(conn, :show, problem))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    problem = Exam.get_problem!(id)
    render(conn, "show.html", problem: problem)
  end

  def edit(conn, %{"id" => id}) do
    problem = Exam.get_problem!(id)
    changeset = Exam.change_problem(problem)
    render(conn, "edit.html", problem: problem, changeset: changeset)
  end

  def update(conn, %{"id" => id, "problem" => problem_params}) do
    problem = Exam.get_problem!(id)

    case Exam.update_problem(problem, problem_params) do
      {:ok, problem} ->
        conn
        |> put_flash(:info, "Problem updated successfully.")
        |> redirect(to: problem_path(conn, :show, problem))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", problem: problem, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    problem = Exam.get_problem!(id)
    {:ok, _problem} = Exam.delete_problem(problem)

    conn
    |> put_flash(:info, "Problem deleted successfully.")
    |> redirect(to: problem_path(conn, :index))
  end
end
