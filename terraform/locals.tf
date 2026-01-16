locals {
  subdomain = var.service

  files = {
    "index.html"     = "text/html"
    "game.js"        = "application/javascript"
    "love.js"        = "application/javascript"
    "game.data"      = "application/wasm"
    "love.wasm"      = "application/wasm"
    "theme/love.css" = "text/css"
    "theme/bg.png"   = "image/png"
  }

  default_tags = {
    Name = var.service
  }
}
