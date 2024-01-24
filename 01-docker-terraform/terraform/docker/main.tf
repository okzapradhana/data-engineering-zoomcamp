provider "docker" {}

resource "docker_image" "postgres" {
  name         = "postgres:13"
}

resource "docker_network" "private_network" {
  name = "zoomcamp_network"
}

resource "docker_container" "postgres" {
  name  = "zoomcamp-postgres"
  image = docker_image.postgres.image_id

  env = [ "POSTGRES_USER=${var.pg_username}", "POSTGRES_PASSWORD=${var.pg_password}", "POSTGRES_DB=${var.pg_db}" ]

  ports {
    internal = 5432
    external = 5432
  }

  networks_advanced {
    name = docker_network.private_network.name
  }
}

resource "docker_image" "pg_admin" {
  name         = "dpage/pgadmin4"
}

resource "docker_container" "pg_admin" {
  name  = "zoomcamp-pgadmin"
  image = docker_image.postgres.image_id

  env = [       
    "PGADMIN_DEFAULT_EMAIL=${var.pg_email}",
    "PGADMIN_DEFAULT_PASSWORD=${var.pg_password}" ]

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.private_network.name
  }
}

