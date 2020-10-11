provider "google" {
  region      = var.region
  project     = var.project_name
  credentials = var.credentials
}


resource "google_compute_instance" "docker" {
  count = 1

  name         = "tf-docker-${count.index}"
  machine_type = "n2-standard-4"
  zone         = var.region_zone
  tags         = ["docker-node"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral
    }
  }

  metadata = {
    ssh-keys = "root:${file("${var.public_key_path}")}"
  }


  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
      agent       = false
      host        = self.network_interface.0.access_config.0.nat_ip 
    }

    inline = [
      "sudo curl -sSL https://get.docker.com/ | sh",
      "sudo usermod -aG docker `echo $USER`",
    #   "sudo docker run -d -p 80:80 nginx"
      "sudo docker run -d -p 80:80 ashwinisoni2206/react-app:latest"
    ]
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

resource "google_compute_firewall" "default" {
  name    = "tf-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80","22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-node"]
}


