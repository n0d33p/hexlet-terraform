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
  zone                     = var.yc_zone
}

resource "yandex_compute_instance" "default" {
  name        = var.server_name
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
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
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

resource "yandex_compute_disk" "default" {
  name     = "disk-name"
  type     = "network-hdd"
  size     = 10
  zone     = var.yc_zone
  image_id = data.yandex_compute_image.img.id // идентификатор образа Ubuntu

  labels = var.resource_labels
}

data "yandex_compute_image" "img" {
  family = "ubuntu-2204-lts"
}

output "show_img" {
  value = data.yandex_compute_image.img
}

resource "yandex_compute_instance" "vm2" {
  name        = "test2"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    disk_id = yandex_compute_disk.vm2.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_compute_disk" "vm2" {
  name     = "disk-name2"
  type     = "network-hdd"
  size     = 10
  zone     = var.yc_zone
  image_id = data.yandex_compute_image.img.id // идентификатор образа Ubuntu

  labels = var.resource_labels
}

resource "yandex_lb_target_group" "default" {
  name      = "target-group"
  target {
    subnet_id = yandex_vpc_subnet.default.id
    address   = yandex_compute_instance.default.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.default.id
    address   = yandex_compute_instance.vm2.network_interface.0.ip_address
  }
}

resource "yandex_lb_network_load_balancer" "default" {
  name = "network-load-balancer"

  listener {
    name = "listener"
    port = 80
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.default.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/ping"
      }
    }
  }
}