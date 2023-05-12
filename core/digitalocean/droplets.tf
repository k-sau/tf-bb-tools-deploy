# Create a web server
resource "digitalocean_droplet" "droplet" {
  image  = var.droplet_image
  name   = var.droplet_name
  region = var.droplet_region
  size   = var.droplet_size
  user_data = file("core/digitalocean/scripts/deploy_tools.sh")
  ssh_keys = [
    # doctl compute ssh-key list
    38294353
  ]
  tags = ["tf"]
}