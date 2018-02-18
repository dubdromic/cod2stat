package main

import (
	"bufio"
	"database/sql"
	"encoding/json"
	_ "github.com/lib/pq"
	"os"
)

func decode() Stats {
	stat := Stats{}
	reader := bufio.NewReader(os.Stdin)
	decoder := json.NewDecoder(reader)
	decoder.Decode(&stat)
	return stat
}

func main() {
	stat := decode()

	db, err := sql.Open("postgres", "user=cod2log dbname=cod2log sslmode=disable")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	map_id := getMapId(db, stat.Mapname)
	game_id := createGame(db, map_id)
	insertGameRows(db, game_id, stat.Lines)
}
