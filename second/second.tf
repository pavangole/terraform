variable "x" {
  type=string
  default="This is pavangole and vaible daible"
}

output "myvalue" {
  value = " You know${var.x} is mad"
}
