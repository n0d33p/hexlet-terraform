variable "yc_token_file" {
  description = "Путь к JSON-ключу service-account"
  type        = string
}
variable "yc_cloud_id" {
  type = string
}
variable "yc_folder_id" {
  type = string
}
variable "yc_zone" {
    description = "Зона доступности Yandex Cloud"
    type = string
    default = "ru-central1-e"
}
variable "resource_labels" {
    type = map(string)
    default = {
        environment = "dev" 
    }
}
variable "server_name" {
    description = "Имя сервера"
    type = string
    default = "test"
}
variable "vm_resources" {
    description = "Ресурсы сервера"
    type = object({
        cores = number
        memory = number
        core_fraction = number
    })
    default = {
        cores = 2
        memory = 4
        core_fraction = 20
    }
}