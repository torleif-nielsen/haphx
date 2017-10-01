defmodule Haphx.ExamTest do
  use Haphx.DataCase

  alias Haphx.Exam

  describe "problems" do
    alias Haphx.Exam.Problem

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def problem_fixture(attrs \\ %{}) do
      {:ok, problem} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exam.create_problem()

      problem
    end

    test "list_problems/0 returns all problems" do
      problem = problem_fixture()
      assert Exam.list_problems() == [problem]
    end

    test "get_problem!/1 returns the problem with given id" do
      problem = problem_fixture()
      assert Exam.get_problem!(problem.id) == problem
    end

    test "create_problem/1 with valid data creates a problem" do
      assert {:ok, %Problem{} = problem} = Exam.create_problem(@valid_attrs)
      assert problem.body == "some body"
      assert problem.title == "some title"
    end

    test "create_problem/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exam.create_problem(@invalid_attrs)
    end

    test "update_problem/2 with valid data updates the problem" do
      problem = problem_fixture()
      assert {:ok, problem} = Exam.update_problem(problem, @update_attrs)
      assert %Problem{} = problem
      assert problem.body == "some updated body"
      assert problem.title == "some updated title"
    end

    test "update_problem/2 with invalid data returns error changeset" do
      problem = problem_fixture()
      assert {:error, %Ecto.Changeset{}} = Exam.update_problem(problem, @invalid_attrs)
      assert problem == Exam.get_problem!(problem.id)
    end

    test "delete_problem/1 deletes the problem" do
      problem = problem_fixture()
      assert {:ok, %Problem{}} = Exam.delete_problem(problem)
      assert_raise Ecto.NoResultsError, fn -> Exam.get_problem!(problem.id) end
    end

    test "change_problem/1 returns a problem changeset" do
      problem = problem_fixture()
      assert %Ecto.Changeset{} = Exam.change_problem(problem)
    end
  end
end
