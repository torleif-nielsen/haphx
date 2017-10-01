defmodule HaphxWeb.ProblemControllerTest do
  use HaphxWeb.ConnCase

  alias Haphx.Exam

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:problem) do
    {:ok, problem} = Exam.create_problem(@create_attrs)
    problem
  end

  describe "index" do
    test "lists all problems", %{conn: conn} do
      conn = get conn, problem_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Problems"
    end
  end

  describe "new problem" do
    test "renders form", %{conn: conn} do
      conn = get conn, problem_path(conn, :new)
      assert html_response(conn, 200) =~ "New Problem"
    end
  end

  describe "create problem" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, problem_path(conn, :create), problem: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == problem_path(conn, :show, id)

      conn = get conn, problem_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Problem"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, problem_path(conn, :create), problem: @invalid_attrs
      assert html_response(conn, 200) =~ "New Problem"
    end
  end

  describe "edit problem" do
    setup [:create_problem]

    test "renders form for editing chosen problem", %{conn: conn, problem: problem} do
      conn = get conn, problem_path(conn, :edit, problem)
      assert html_response(conn, 200) =~ "Edit Problem"
    end
  end

  describe "update problem" do
    setup [:create_problem]

    test "redirects when data is valid", %{conn: conn, problem: problem} do
      conn = put conn, problem_path(conn, :update, problem), problem: @update_attrs
      assert redirected_to(conn) == problem_path(conn, :show, problem)

      conn = get conn, problem_path(conn, :show, problem)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, problem: problem} do
      conn = put conn, problem_path(conn, :update, problem), problem: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Problem"
    end
  end

  describe "delete problem" do
    setup [:create_problem]

    test "deletes chosen problem", %{conn: conn, problem: problem} do
      conn = delete conn, problem_path(conn, :delete, problem)
      assert redirected_to(conn) == problem_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, problem_path(conn, :show, problem)
      end
    end
  end

  defp create_problem(_) do
    problem = fixture(:problem)
    {:ok, problem: problem}
  end
end
