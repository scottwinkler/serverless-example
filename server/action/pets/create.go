package pets

import (
	"github.com/google/uuid"
	"github.com/jinzhu/gorm"
	"github.com/scottwinkler/serverless-example/server/model/pet"
)

//CreatePetRequest request struct
type CreatePetRequest struct {
	Name  string `json:"name" binding:"required"`
	Breed string `json:"breed" binding:"required"`
	Color string `json:"color" binding:"required"`
}

//CreatePetResponse response struct
type CreatePetResponse struct {
	ID string `json:"id"`
}

//CreatePet creates a pet in database
func CreatePet(db *gorm.DB, req *CreatePetRequest) (*CreatePetResponse, error) {
	uuid, _ := uuid.NewRandom()
	newPet := &pet.Pet{
		ID:    uuid.String(),
		Name:  req.Name,
		Breed: req.Breed,
		Color: req.Color,
	}
	id, err := pet.Create(db, newPet)
	res := &CreatePetResponse{ID: id}
	return res, err
}
