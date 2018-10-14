package main

import (
	"fmt"
	"net/http"
	"os"
	"strconv"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/awslabs/aws-lambda-go-api-proxy/gin"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/scottwinkler/serverless-example/server/action/pets"
	"github.com/scottwinkler/serverless-example/server/model/pet"
)

var ginLambda *ginadapter.GinLambda
var db *gorm.DB

func init() {
	initializeRDSConn()
	validateRDS()
	initializeGin()
}

func initializeRDSConn() {
	user := os.Getenv("rds_user")
	password := os.Getenv("rds_password")
	host := os.Getenv("rds_host")
	port := os.Getenv("rds_port")
	database := os.Getenv("rds_database")
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", user, password, host, port, database)
	var err error
	db, err = gorm.Open("mysql", dsn)
	if err != nil {
		fmt.Printf("%s", err)
	}
}

func validateRDS() {
	//If the pets table does not already exist, create it
	if !db.HasTable("pets") {
		db.CreateTable(&pet.Pet{})
	}
}

func initializeGin() {
	r := gin.Default()
	r.POST("/pets", createPetHandler)
	r.GET("/pets/:id", getPetHandler)
	r.GET("/pets", listPetsHandler)
	ginLambda = ginadapter.New(r)
}

//Handler is the entry function that gets called by AWS Lambda
func Handler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return ginLambda.Proxy(req)
}

func main() {
	lambda.Start(Handler)
}

func createPetHandler(c *gin.Context) {
	c.Header("Access-Control-Allow-Origin", "*")
	var req pets.CreatePetRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	res, err := pets.CreatePet(db, &req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, res)
	return
}

func listPetsHandler(c *gin.Context) {
	c.Header("Access-Control-Allow-Origin", "*")
	limit := 10
	if c.Query("limit") != "" {
		newLimit, err := strconv.Atoi(c.Query("limit"))
		if err != nil {
			limit = 10
		} else {
			limit = newLimit
		}
	}
	if limit > 50 {
		limit = 50
	}
	req := pets.ListPetsRequest{Limit: uint(limit)}
	res, _ := pets.ListPets(db, &req)
	c.JSON(http.StatusOK, res)
}

func getPetHandler(c *gin.Context) {
	c.Header("Access-Control-Allow-Origin", "*")
	id := c.Param("id")
	req := pets.GetPetRequest{ID: id}
	res, _ := pets.GetPet(db, &req)
	if res.Pet == nil {
		c.JSON(http.StatusNotFound, res)
		return
	}
	c.JSON(http.StatusOK, res)
}
