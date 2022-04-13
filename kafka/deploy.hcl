metadata {
  path = "kafka"
  name = "deploy"
}

step "terraform-init" {
  wkdir   = "kafka/terraform"
  target  = "kafka/terraform"
  command = "terraform"

  args = [
    "init",
    "-upgrade",
  ]

  sha     = "h1:DJrRX3mzKqySM4VmunuZtaNZ3Ga8Suu+5S3x7ycOccc="
  retries = 0
}

step "terraform-apply" {
  wkdir   = "kafka/terraform"
  target  = "kafka/terraform"
  command = "terraform"

  args = [
    "apply",
    "-auto-approve",
  ]

  sha     = "h1:DJrRX3mzKqySM4VmunuZtaNZ3Ga8Suu+5S3x7ycOccc="
  retries = 1
}

step "terraform-output" {
  wkdir   = "kafka"
  target  = "kafka/terraform"
  command = "plural"

  args = [
    "output",
    "terraform",
    "kafka",
  ]

  sha     = "h1:DJrRX3mzKqySM4VmunuZtaNZ3Ga8Suu+5S3x7ycOccc="
  retries = 0
}

step "kube-init" {
  wkdir   = "kafka"
  target  = "kafka/.plural/NONCE"
  command = "plural"

  args = [
    "wkspace",
    "kube-init",
  ]

  sha     = "b2216522cc4502899a95c1f6917686abd20bbdb57a9c8b9ee23e8f0eacdd1927"
  retries = 0
}

step "crds" {
  wkdir   = "kafka"
  target  = "kafka/crds"
  command = "plural"

  args = [
    "wkspace",
    "crds",
    "kafka",
  ]

  sha     = "h1:R5aMMRvui09Sy/V4GIuS0McmqqdahbO1k7U/XsD6Zng="
  retries = 0
}

step "bounce" {
  wkdir   = "kafka"
  target  = "kafka/helm"
  command = "plural"

  args = [
    "wkspace",
    "helm",
    "kafka",
  ]

  sha     = "h1:kkcaT10BRUnDWo2t2Elpf9ZmbHzFfR5FA3rcNT7hyQA="
  retries = 1
}
