package pet

type Pet struct {
	ID    string `gorm:"primary_key" json:"id"`
	Name  string `json:"name"`
	Breed string `json:"breed"`
	Color string `json:"color"`
}
