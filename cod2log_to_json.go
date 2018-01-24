package main

import (
	"bufio"
	"encoding/json"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func lineDelimiter() *regexp.Regexp {
	return regexp.MustCompile(";|:|\\\\")
}

func (l *Line) parseKDLine(parts []string) {
	l.Linetype = parts[0]
	l.Victimteam = parts[3]
	l.Victimname = parts[4]
	l.Attackerteam = parts[7]
	l.Attackername = parts[8]
	i, err := strconv.Atoi(parts[10])
	if err != nil {
		panic(err)
	}
	l.Damage = i
	l.Weaponname = parts[9]
	l.Weapontype = parts[11]
	l.Weaponlocation = parts[12]
}

func (s *Stats) parseLine(line_number int, line string) {
	if line == "" {
		return
	}
	data_re := lineDelimiter()
	line_parts := strings.SplitAfterN(line, " ", 2)
	deets := data_re.Split(line_parts[1], -1)
	l := Line{}
	l.Number = line_number
	l.Time = strings.TrimSpace(line_parts[0])
	if deets[0] == "K" || deets[0] == "D" {
		l.parseKDLine(deets)
		s.Lines = append(s.Lines, l)
	} else if deets[0] == "InitGame" {
		s.Mapname = deets[9]
	}
}

func main() {
	stat := Stats{}

	scanner := bufio.NewScanner(os.Stdin)
	i := 0
	for scanner.Scan() {
		stat.parseLine(i, scanner.Text())
		i++
	}

	json, err := json.Marshal(stat)
	if err != nil {
		panic(err)
	}

	os.Stdout.Write(json)

	if err := scanner.Err(); err != nil {
		panic(err)
	}

}
