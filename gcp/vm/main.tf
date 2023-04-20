# Create a single Compute Engine instance
resource "google_compute_instance" "dvwa_instance_1" {
  name         = "dvwa-vm-1"
  machine_type = "e2-micro"
  zone         = "europe-west2-a"
  tags         = ["allow-http-from-lb","allow-health-check","allow-ssh"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20230114"
    }
  }

  # Install docker
    metadata_startup_script = <<-EOF
    sudo apt update && \
    sudo apt install docker docker.io -y && \
    sudo docker pull jibba/web-dvwa:project && \
    sudo docker run -d -it -p 80:80 jibba/web-dvwa:project
    EOF

  network_interface {
    subnetwork = var.nic_2

    access_config {
      
    }
  }
  metadata = {    
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }
}

resource "google_compute_instance" "dvwa_instance_2" {
    name         = "dvwa-vm-2"
    machine_type = "e2-micro"
    zone         = "europe-west2-a"
    tags         = ["allow-http-from-lb","allow-health-check","allow-ssh"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20230114"
    }
  }

  # Install docker
  metadata_startup_script = <<-EOF
    !/bin/bash
    sudo apt update && \
    sudo apt install docker docker.io -y && \
    sudo docker pull jibba/web-dvwa:project && \
    sudo docker run -d -it -p 80:80 jibba/web-dvwa:project
    EOF
  
  
  network_interface {
    subnetwork = var.nic_2

    access_config {
      
    }
  }
  metadata = {    
    "ssh-keys" = "james:${file(var.public_key)}"
  }
}

resource "google_compute_instance_group" "dvwa-backend" {
  name        = "dvwa-backend"
  description = "dvwa-backend"
  zone = "europe-west2-a"
  instances = [google_compute_instance.dvwa_instance_1.id, google_compute_instance.dvwa_instance_2.id]

  named_port {
    name = "http"
    port = "80"
  }
  
} 