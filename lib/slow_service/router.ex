defmodule SlowService.Router do
  alias SlowService.{Stage}

  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)

  plug(:match)
  plug(:dispatch)

  get "/simulate/:param_start_timestamp_seconds" do
    start_timestamp = String.to_integer(param_start_timestamp_seconds)

    current_duration = Stage.current_duration(start_timestamp)
    {status, latency} = Stage.response_data(current_duration)

    Process.sleep(latency)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(status, "Current duration: #{Stage.current_duration(start_timestamp)} seconds \nstatus: #{status} \nlatency: #{latency}")
  end

  get "/time_since/:param_start_timestamp_seconds" do
    start_timestamp = String.to_integer(param_start_timestamp_seconds)
    current_duration = Stage.current_duration(start_timestamp)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "#{current_duration}")
  end

  get "/timestamp" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "#{DateTime.utc_now |> DateTime.to_unix}.")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
