variable "REGISTRY" {
  default = "ghcr.io"
}

variable "GITHUB_USERNAME" {
  default = "halkony"
}

variable "DOCKERHUB_IMG" {
  default = "worker-comfyui"
}

variable "RELEASE_VERSION" {
  default = "latest"
}

variable "HUGGINGFACE_ACCESS_TOKEN" {
  default = ""
}

group "default" {
  targets = ["base", "sdxl", "sd3", "flux1-schnell", "flux1-dev"]
}

target "base" {
  context = "."
  dockerfile = "Dockerfile"
  target = "base"
  platforms = ["linux/amd64"]
  args = {
    MODEL_TYPE = "base"
  }
  tags = ["${REGISTRY}/${GITHUB_USERNAME}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-base"]
}

target "sdxl" {
  context = "."
  dockerfile = "Dockerfile"
  target = "final"
  args = {
    MODEL_TYPE = "sdxl"
  }
  tags = ["${REGISTRY}/${GITHUB_USERNAME}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-sdxl"]
  inherits = ["base"]
}

target "sd3" {
  context = "."
  dockerfile = "Dockerfile"
  target = "final"
  args = {
    MODEL_TYPE = "sd3"
    HUGGINGFACE_ACCESS_TOKEN = "${HUGGINGFACE_ACCESS_TOKEN}"
  }
  tags = ["${REGISTRY}/${GITHUB_USERNAME}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-sd3"]
  inherits = ["base"]
}

target "flux1-schnell" {
  context = "."
  dockerfile = "Dockerfile"
  target = "final"
  args = {
    MODEL_TYPE = "flux1-schnell"
    HUGGINGFACE_ACCESS_TOKEN = "${HUGGINGFACE_ACCESS_TOKEN}"
  }
  tags = ["${REGISTRY}/${GITHUB_USERNAME}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-flux1-schnell"]
  inherits = ["base"]
}

target "flux1-dev" {
  context = "."
  dockerfile = "Dockerfile"
  target = "final"
  args = {
    MODEL_TYPE = "flux1-dev"
    HUGGINGFACE_ACCESS_TOKEN = "${HUGGINGFACE_ACCESS_TOKEN}"
  }
  tags = ["${REGISTRY}/${GITHUB_USERNAME}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-flux1-dev"]
  inherits = ["base"]
}

target "flux1-kontext-dev-fp8" {
  context = "."
  dockerfile = "Dockerfile"
  target = "final"
  args = {
    MODEL_TYPE = "flux1-kontext-dev-fp8"
    HUGGINGFACE_ACCESS_TOKEN = "${HUGGINGFACE_ACCESS_TOKEN}"
  }
  tags = ["${REGISTRY}/${GITHUB_USERNAME}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-flux1-kontext-dev-fp8"]
  inherits = ["base"]
}

target "flux1-dev-fp8" {
  context = "."
  dockerfile = "Dockerfile"
  target = "final"
  tags = ["${REGISTRY}/${GITHUB_USERNAME}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-flux1-dev-fp8"]
  inherits = ["base"]
}

