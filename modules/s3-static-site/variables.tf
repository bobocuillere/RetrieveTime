variable "project_name" {
  description = "Project identifier"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

variable "frontend_path" {
  description = "Absolute path to the built static site on local disk"
  type        = string
}

variable "mime_types" {
  description = "Map of file extensions to content types"
  type        = map(string)
  default = {
    css  = "text/css"
    js   = "application/javascript"
    json = "application/json"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    svg  = "image/svg+xml"
    ico  = "image/x-icon"
    html = "text/html"
    map  = "application/json"
  }
}
