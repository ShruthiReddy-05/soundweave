#For mixing any 2 audio tracks
Membrane.Pipeline.start_link(MP3Encoder.AudioMixPipeline, %{
    output_file: "output_mix.mp3",
    audio_track1: "sample_audio.mp3",
    audio_track2: "sample.mp3"})

# # For mixing audio track and mic recording
# {:ok, _pipeline_supervisor, _pid} =
#   Membrane.Pipeline.start_link(MP3Encoder.AudioPipeline, %{
#     output_file: "output1.mp3",
#     background_track: "sample.mp3"})

## For audio_player.ex:
#Membrane.Pipeline.start_link(Membrane.Demo.SimplePipeline, "sample.mp3")

#{:ok, _pipeline_supervisor, _pid} = Membrane.Pipeline.start_link(MP3Encoder.Pipeline, "output.mp3")
