package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
)

func main() {
	stat := Stats{}
	reader := bufio.NewReader(os.Stdin)
	decoder := json.NewDecoder(reader)
	decoder.Decode(&stat)
	fmt.Println("json", stat)
}
