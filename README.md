# cod2stat

AKA cod2log v2

## Setup

Create a database user `cod2log` with createdb and dropdb permissions, then run this:

```
./setup # drops db, creates db, loads structure, loads seeds
./process # processes mp_server.log; do FILE=other_log.log to change file
```

## Usage

To view the last game:

```
psql -U cod2log -f last_game.sql cod2log
```

To view one player's vs stats for the last game:

```
psql -U cod2log -f player_stats.sql -v pn='player name here' cod2log
```

## TODO

- `casualties` indexes
- Combine ETL into single Go process (maybe 1 routine per game chunked up to CPU count?)
- Immediately hash line to determine skippability; requires generating a game_id at the start of a chunk
- Additional stats; player's weapon usage, grenade counts, etc
