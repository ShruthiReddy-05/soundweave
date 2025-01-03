#for audio recorder
{:ok, _pipeline_supervisor, _pid} =
  Membrane.Pipeline.start_link(MP3Encoder.Pipeline, "output.mp3")

## For audio_player.ex:
#Membrane.Pipeline.start_link(Membrane.Demo.SimplePipeline, "sample.mp3")
