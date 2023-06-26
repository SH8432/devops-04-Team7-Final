variable "db_username" {
  type        = string
  description = "Username for the database"
  default = "username"
}

variable "db_password" {
  type        = string
  description = "Password for the database"
  default = "password"
}

variable "db_name" {
  type        = string
  description = "Name for the database"
  default = "name"
}

variable "db_hostname" {
  type        = string
  description = "Hostname for the database"
  default = "hostname"
}

variable "app_name" {
  type = string
  default = "final-project-service"
}

variable "container_name" {
  type = string
  default = "final-project-ecs-task"
}

variable "container_port" {
  type    = number
  default = 4000
}

variable "domain" {
  type = string
  default = "loveliverpool.click"
}

variable "domain-certificate" {
  type = string
  default = "*.loveliverpool.click"
}