terraform {
  backend "local" {
    path = "../../state/stage.tfstate"
  }
}