package main

import (
	"database/sql"
	"github.com/cnf/structhash"
	"github.com/lib/pq"
)

func insertGameRows(db *sql.DB, game_id string, lines []Line) {
	weapon_to_id := getMappingForTable(db, "weapons")
	weapon_type_to_id := getMappingForTable(db, "damage_types")
	location_to_id := getMappingForTable(db, "damage_locations")

	txn, err := db.Begin()
	panicIfErr(err)

	st, err := txn.Prepare(pq.CopyIn("casualties_staging", "game_id", "line_number", "timestamp", "line_type", "victim_team", "victim_name", "attacker_team", "attacker_name", "weapon_id", "damage_type_id", "damage", "damage_location_id", "hash"))
	panicIfErr(err)

	for _, line := range lines {
		_, err = st.Exec(game_id, line.Number, line.Time, line.Linetype, line.Victimteam, line.Victimname, line.Attackerteam, line.Attackername, weapon_to_id[line.Weaponname], weapon_type_to_id[line.Weapontype], line.Damage, location_to_id[line.Weaponlocation], structhash.Sha1(line, 1))
		panicIfErr(err)
	}

	_, err = st.Exec()
	panicIfErr(err)

	err = st.Close()
	panicIfErr(err)

	_, err = txn.Exec(`INSERT INTO casualties ("game_id", "line_number", "timestamp", "line_type", "victim_team", "victim_name", "attacker_team", "attacker_name", "weapon_id", "damage_type_id", "damage", "damage_location_id", "hash") SELECT "game_id", "line_number", "timestamp", "line_type", "victim_team", "victim_name", "attacker_team", "attacker_name", "weapon_id", "damage_type_id", "damage", "damage_location_id", "hash" FROM casualties_staging ON CONFLICT DO NOTHING`)
	panicIfErr(err)

	err = txn.Commit()
	panicIfErr(err)
}

func getMappingForTable(db *sql.DB, table_name string) map[string]int {
	results := make(map[string]int)
	rows, err := db.Query("select id, identifier from " + table_name)
	panicIfErr(err)
	for rows.Next() {
		var id int
		var identifier string
		err = rows.Scan(&id, &identifier)
		panicIfErr(err)
		results[identifier] = id
	}
	return results
}

func createGame(db *sql.DB, map_id int) string {
	var game_id string
	err := db.QueryRow("insert into games (map_id) values ($1) returning id;", map_id).Scan(&game_id)
	panicIfErr(err)
	return game_id
}

func getMapId(db *sql.DB, map_name string) int {
	var map_id int
	err := db.QueryRow("select id from maps where identifier = $1;", map_name).Scan(&map_id)
	result := resultOrPanic(err, map_id, "map name: "+map_name)
	return result
}

func resultOrPanic(err error, result int, info string) int {
	switch {
	case err == sql.ErrNoRows:
		panic("no rows for " + info)
	case err != nil:
		panic(err)
	default:
		return result
	}
}
