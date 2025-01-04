defmodule MP3Encoder.AudioPipeline do
  use Membrane.Pipeline

  @impl true
  def handle_init(_ctx, %{output_file: output_file, background_track: bg_track}) do
    structure = [
      # Background track path
      child(:background_source, %Membrane.File.Source{
        location: bg_track
      })
      |> child(:background_decoder, Membrane.MP3.MAD.Decoder)
      |> child(:background_converter, %Membrane.FFmpeg.SWResample.Converter{
        output_stream_format: %Membrane.RawAudio{
          channels: 2,
          sample_format: :s16le,
          sample_rate: 44_100
        }
      })
      |> get_child(:mixer),

      # Microphone input path
      child(:microphone, %Membrane.PortAudio.Source{
        channels: 2,
        sample_format: :s16le,
        sample_rate: 48_000
      })
      |> child(:mic_converter, %Membrane.FFmpeg.SWResample.Converter{
        output_stream_format: %Membrane.RawAudio{
          channels: 2,
          sample_format: :s16le,
          sample_rate: 44_100
        }
      })
      |> via_in(:input)
      |> get_child(:mixer),

      # Mixer and output path
      child(:mixer, %Membrane.AudioMixer{
        stream_format: %Membrane.RawAudio{
          channels: 2,
          sample_rate: 44_100,
          sample_format: :s16le
        }
      })
      |> child(:converter, %Membrane.FFmpeg.SWResample.Converter{
        output_stream_format: %Membrane.RawAudio{
          channels: 2,
          sample_format: :s32le,
          sample_rate: 44_100
        }
      })
      |> child(:encoder, Membrane.MP3.Lame.Encoder)
      |> child(:sink, %Membrane.File.Sink{location: output_file})
    ]

    {[spec: structure], %{}}
  end
end
