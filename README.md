# An elixir app to simulate a slow backend service

## Run locally

```sh
make dependencies

make compile

make run
```

## Endpoints
`/timestamp` - get a current timestamp to use
`/time_since/{{start_timestamp_seconds}}` - gives you the number of seconds since the provided timestamp
`/simulate/{{start_timestamp_seconds}}` - runs the simulation 
