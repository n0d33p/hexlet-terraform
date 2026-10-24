terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.100"
    }
  }
}
provider "yandex" {
  service_account_key_file = var.yc_token_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = "ru-central1-d"
}

resource "yandex_compute_instance" "default" {
  name        = "test"
  platform_id = "standard-v1"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    disk_id = yandex_compute_disk.default.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_vpc_network" "default" {
}

resource "yandex_vpc_subnet" "default" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

resource "yandex_compute_disk" "default" {
  name      = "disk-name"
  type      = "network-hdd"
  size      = 20
  zone      = "ru-central1-e"
  image_id  = "fd83s8u085j3mq231ago" // идентификатор образа Ubuntu

  labels = {
    environment = "test"
  }
}