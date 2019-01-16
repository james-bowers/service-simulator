defmodule SlowService.Stage do
  def response_data(duration) do
    case duration do
      seconds when seconds in 1..150 -> {200, 100}
      seconds when seconds in 150..160 -> {500, 650}
      seconds when seconds in 160..300 -> {408, 1000}
      seconds when seconds in 300..350 -> {200, 300}
      _ ->
        {200, 100}
    end
  end

  def current_duration(start_timestamp) do
    {:ok, date_time_at_start} = DateTime.from_unix(start_timestamp, :second)

    DateTime.diff(DateTime.utc_now, date_time_at_start, :second)
  end
end
