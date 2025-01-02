# defmodule Jam.AudioPlayer do
#   alias Jam.Repo
#   alias Jam.Track

#   def add_audio_track(params) do
#     %Track{}
#     |> Track.changeset(params)
#     |> Repo.insert()
#   end

#   def play_audio_track(track_id) do
#     with {:ok, track} <- get_track(track_id) do
#       # Update track status to "playing"
#       Track.changeset(track, %{status: "playing"})
#       |> Repo.update()
#     end
#   end

#   def pause_audio_track(track_id) do
#     with {:ok, track} <- get_track(track_id) do
#       # Update track status to "paused"
#       Track.changeset(track, %{status: "paused"})
#       |> Repo.update()
#     end
#   end

#   def stop_audio_track(track_id) do
#     with {:ok, track} <- get_track(track_id) do
#       # Update track status to "stopped"
#       Track.changeset(track, %{status: "stopped"})
#       |> Repo.update()
#     end
#   end

#   defp get_track(track_id) do
#     case Repo.get(Track, track_id) do
#       nil -> {:error, :not_found}
#       track -> {:ok, track}
#     end
#   end
# end
