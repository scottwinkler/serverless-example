package pets

import (
	"github.com/jinzhu/gorm"
	"github.com/scottwinkler/serverless-example/server/model/pet"
)

//ListPetRequest request struct
type ListPetsRequest struct {
	Limit uint
}

//ListPetResponse response struct
type ListPetsResponse struct {
	Pets *[]pet.Pet `json:"pets"`
}

//ListPets returns a list of pets from database
func ListPets(db *gorm.DB, req *ListPetsRequest) (*ListPetsResponse, error) {
	pets, err := pet.List(db, req.Limit)
	res := &ListPetsResponse{Pets: pets}
	return res, err
}
