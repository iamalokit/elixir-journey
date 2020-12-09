defmodule KV.Registry do
  use GenServer

  @doc """
  Starts the registry
  """

  # Param1 - module where the server callbacks are implemented - __MODULE__ represents current module
  # Param2- the initialization arguments , in this case the atom :ok
  # Param3- list of options - can be used to specify the name of the server

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the bucket pid for `name` stored in `server`.

  Returns `{ok, pid}` if bucket exists, `:error` otherwise.
  """

  # This function is used to send request to the server
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a bucket associated with the given `name` in `server`.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  ## Defining server call backs
  @impl true
  def init(:ok) do
    # Defing the state of the server on initializing
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  # used for synchronous request 
  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {names, _} = state
    {:reply, Map.fetch(names, name), state}
  end

  # used for asynchronous request 
  @impl true
  def handle_cast({:create, name}, {names, refs}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, refs}}
    else
      {:ok, pid} = DynamicSupervisor.start_child(KV.BucketSupervisor, KV.Bucket)
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, pid)
      {:noreply, {names, refs}}
    end
  end

  # used for all other messages sent to the server except from cast, call
  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
