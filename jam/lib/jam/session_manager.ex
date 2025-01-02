defmodule RealTimeJamming.SessionManager do
  @moduledoc """
  Module for managing real-time jamming sessions using ETS.
  """

  # Create a session in the ETS table
  def create_session(session_id) do
    :ets.insert(:sessions, {session_id, %{participants: []}})
  end

  # Add a participant to a session
  def add_participant(session_id, user_id) do
    case :ets.lookup(:sessions, session_id) do
      [{_key, session_data}] ->
        updated_data = Map.update!(session_data, :participants, fn participants ->
          participants ++ [user_id]
        end)
        :ets.insert(:sessions, {session_id, updated_data})
        :ok

      [] -> :error
    end
  end

  # Get session data
  def get_session(session_id) do
    case :ets.lookup(:sessions, session_id) do
      [{_key, session_data}] -> {:ok, session_data}
      [] -> :error
    end
  end
end