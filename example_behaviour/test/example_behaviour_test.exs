defmodule ExampleBehaviourTest do
  use ExUnit.Case
  doctest ExampleBehaviour

  test "greets the world" do
    assert ExampleBehaviour.hello() == :world
  end
end
