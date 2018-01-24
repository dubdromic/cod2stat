package main

type Stats struct {
	Lines   []Line `json:"lines"`
	Mapname string `json:"map_name"`
}

type Line struct {
	Number         int    `json:"line_number"`
	Time           string `json:"timestamp"`
	Linetype       string `json:"line_type"`
	Victimteam     string `json:"victim_team"`
	Victimname     string `json:"victim_name"`
	Attackerteam   string `json:"attacker_team"`
	Attackername   string `json:"attacker_name"`
	Weaponname     string `json:"weapon_name"`
	Weapontype     string `json:"weapon_type"`
	Damage         int    `json:"damage"`
	Weaponlocation string `json:"location"`
}
