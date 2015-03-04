package main

import (
	"database/sql"
	"fmt"
	_ "github.com/mattn/go-oci8"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", homeHandler)
	panic(http.ListenAndServe(":8080", nil))
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	testeoracle := executa()
	//fmt.Println(testeoracle)
	body := "<html><head></head><body>" + "<h1>Agentes</h1>" + "<h2>" + testeoracle + "</h2>" + "</body></html>"
	fmt.Fprintf(w, body)
}

func executa() string {
	os.Setenv("NLS_LANG", ".UTF8")
	db, err := sql.Open("oci8", "system/manager@pc_joao/orc1")

	defer db.Close()

	rows, err := db.Query("select agn_st_nome from mgglo.glo_agentes where agn_in_codigo <= 10 order by agn_in_codigo")

	if err != nil {
		return "erro"
	}

	var agentes string
	for rows.Next() {
		var nome string
		rows.Scan(&nome)
		agentes = agentes + nome
	}

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	defer rows.Close()

	return agentes

}
