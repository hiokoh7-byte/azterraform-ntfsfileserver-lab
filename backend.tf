terraform {
backend "azurerm" {
resource_group_name = "RG-TerraformState"
storage_account_name = "tfstatentfshd01"
container_name = "tfstate"
key = "ntfs-lab.terraform.tfstate"
# Lab 2 uses key = "rbac-lab.terraform.tfstate"
# Both labs share the same container without overwriting each other
}
}