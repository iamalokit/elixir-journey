defmodule KV.Bucket do
  use Agent

  @doc """
  Starts a new bucket.
  """

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  gets a value from the 'bucket' by 'key'.
  """

  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  @doc """
  puts the 'value' for the given 'key' in the 'bucket'.
  """

  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  # Breaking the put function code apart
  def put(bucket, key, value) do
    # client code
    Agent.update(bucket, fn state ->
      # server code
      Map.put(state, key, value)
    end)
  end

  @doc """
  Deletes `key` from the bucket 
  Returns the current value of `key` , if `key` exists.
  """

  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end

  # expanded delete function in 
  # def delete(bucket, key) do
  #     Agent.get_and_update(bucket, fn dict ->
  #     Map.pop(dict, key)
  #     end)
  # end

  # Sleeping Client and Serve
  # def delete(bucket, key) do
  #     Process.sleep(1000)
  #     Agent.get_and_update(bucket, fn dict ->
  #     Process.sleep(1000)
  #     Map.pop(dict, key)
  #     end)
  # end
end
