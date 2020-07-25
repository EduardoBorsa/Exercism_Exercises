defmodule RobotSimulator do
  defguard is_position(x, y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    create_state(direction, position)
  end

  def create_state(direction, {x, y})
      when is_position(x, y) and direction in [:north, :east, :west, :south] do
    %{direction: direction, position: {x, y}}
  end

  def create_state(_, {x, y}) when is_number(x) and is_number(y) do
    {:error, "invalid direction"}
  end

  def create_state(_, _) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) when is_binary(instructions) do
    simulate(robot, String.graphemes(instructions))
  end

  def simulate(robot, []), do: robot

  def simulate(robot, ["L" | t]) do
    case robot[:direction] do
      :north ->
        %{robot | direction: :west}
        |> simulate(t)

      :west ->
        %{robot | direction: :south}
        |> simulate(t)

      :south ->
        %{robot | direction: :east}
        |> simulate(t)

      :east ->
        %{robot | direction: :north}
        |> simulate(t)
    end
  end

  def simulate(robot, ["R" | t]) do
    case robot[:direction] do
      :north ->
        %{robot | direction: :east}
        |> simulate(t)

      :east ->
        %{robot | direction: :south}
        |> simulate(t)

      :south ->
        %{robot | direction: :west}
        |> simulate(t)

      :west ->
        %{robot | direction: :north}
        |> simulate(t)
    end
  end

  def simulate(robot, ["A" | t]) do
    case robot do
      %{direction: :north, position: {x, y}} ->
        %{robot | position: {x, y + 1}}
        |> simulate(t)

      %{direction: :west, position: {x, y}} ->
        %{robot | position: {x - 1, y}}
        |> simulate(t)

      %{direction: :south, position: {x, y}} ->
        %{robot | position: {x, y - 1}}
        |> simulate(t)

      %{direction: :east, position: {x, y}} ->
        %{robot | position: {x + 1, y}}
        |> simulate(t)
    end
  end

  def simulate(_robot, _list), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: dir}), do: dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: position}), do: position
end
