defmodule ExampleBehaviour.CLI do

  @moduledoc """
  This module handles the command line interface portion of the application
  """

  @doc """
  This is the main CLI Entry point

  This function currently ignores any command line arguments
  """

  def main(_argv) do
    process()
  end

  @doc """
  Runs the program logic
  """

  def process() do
    log_list = fill_log_list([])
    logger = get_random_logger()
    log_list = logger.log_data(log_list, get_random_log_level(), %{name: "Zim", occupation: :invader})

    print_log_list(log_list)
  end

  defp get_random_log_level() do
    Enum.random([:info, :warning, :error])
  end

  defp get_random_logger() do
    Enum.random([BehaviourExample.LowerCaseLogger, BehaviourExample.UpperCaseLogger])
  end

  def fill_log_list(log_list) do
    IO.gets("> ") |> String.trim() |> handle_message(log_list)
  end

  defp handle_message("", log_list),  do: log_list
  defp handle_message(message, log_list) do
    logger = get_random_logger()
    log_list = logger.log_message(log_list, get_random_log_level(), message)

    fill_log_list(log_list)
  end

  @doc """
  Prints a log list to the console
  """

  def print_log_list(log_list) do
    print_separator()

    log_list
    |> Enum.reverse()
    |> Enum.each(&print_log_entry/1)
  end

  # prints a separotor to separate content
  defp print_separator(), do: IO.puts("-----------------------")

  # Displays a log entry on its own line in the console
  defp print_log_entry(log_entry) do
    log_entry
    |> get_printable_log_entry()
    |> IO.puts()
  end

  defp get_printable_log_entry(log_entry) do
    log_level = get_printable_log_level(log_entry)
    log_message = get_printable_log_message(log_entry)
    "#{log_level} - #{log_message}"
  end

  defp get_printable_log_level(log_entry) do
    "#{inspect(elem(log_entry, 0))}"
  end

  defp get_printable_log_message(log_entry) do
    "\"#{elem(log_entry, 1)} \""
  end
end
