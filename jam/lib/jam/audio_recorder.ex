defmodule MP3Encoder.Pipeline do
  use Membrane.Pipeline

  alias Membrane.FFmpeg.SWResample.Converter

  @impl true
  def handle_init(_ctx, filename) do
    spec =
      child(:portaudio, %Membrane.PortAudio.Source{
        channels: 2,
        sample_format: :s16le,
        sample_rate: 48_000
      })
      |> child(:converter, %Converter{
        output_stream_format: %Membrane.RawAudio{
          channels: 2,
          sample_format: :s32le,
          sample_rate: 44_100
        }
      })
      |> child(:encoder, Membrane.MP3.Lame.Encoder)
      |> child(:file, %Membrane.File.Sink{location: filename})

    {[spec: spec], %{}}
  end
end
