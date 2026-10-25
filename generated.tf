# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "bg016a49kk169ntod1is"
resource "yandex_compute_instance" "vm" {
  allow_recreate            = null
  allow_stopping_for_update = null
  description               = null
  folder_id                 = "b1gkel6dkii7jqjrkl08"
  hostname                  = "test2"
  labels                    = {}
  metadata = {
    private_ui_created_from = "console"
    ssh-keys                = "wh0am1:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIn+yfovgTimQMclbl7OfTEzlwK7wfkC6ircMRhvgHU6 Yandex Cloud"
    user-data               = "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: wh0am1\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIn+yfovgTimQMclbl7OfTEzlwK7wfkC6ircMRhvgHU6 Yandex Cloud"
  }
  name                      = "test2"
  network_acceleration_type = "standard"
  platform_id               = "standard-v3"
  service_account_id        = null
  zone                      = "ru-central1-e"
  boot_disk {
    auto_delete = false
    device_name = "bg0ta4obkt8n9jaa2cd7"
    disk_id     = "bg0ta4obkt8n9jaa2cd7"
    mode        = "READ_WRITE"
    initialize_params {
      block_size = 4096
      image_id   = "fd8tqd3ee9ii1avc9o5e"
      kms_key_id = null
      name       = "disk-ubuntu-24-04-lts-1792965190528"
      size       = 10
      type       = "network-hdd"
    }
  }
  metadata_options {
    aws_v1_http_endpoint = 1
    aws_v1_http_token    = 2
    aws_v2_http_endpoint = 1
    aws_v2_http_token    = 1
    gce_http_endpoint    = 1
    gce_http_token       = 1
  }
  network_interface {
    index              = 0
    ip_address         = "10.5.0.19"
    ipv4               = true
    ipv6               = false
    nat                = false
    security_group_ids = []
    subnet_id          = "ajciddekfhdua26hdkqm"
  }
  placement_policy {
    host_affinity_rules       = []
    placement_group_id        = null
    placement_group_partition = 0
  }
  resources {
    core_fraction = 20
    cores         = 2
    gpus          = 0
    memory        = 2
  }
  scheduling_policy {
    preemptible = false
  }
}
