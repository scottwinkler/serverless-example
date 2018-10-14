package pets

import (
	"github.com/jinzhu/gorm"
	"github.com/scottwinkler/serverless-example/server/model/pet"
)

//GetPetRequest request struct
type GetPetRequest struct {
	ID string
}

//GetPetResponse response struct
type GetPetResponse struct {
	Pet *pet.Pet `json:"pet"`
}

//GetPet returns a pet from database
func GetPet(db *gorm.DB, req *GetPetRequest) (*GetPetResponse, error) {
	pet, err := pet.FindById(db, req.ID)
	res := &GetPetResponse{Pet: pet}
	return res, err
}
