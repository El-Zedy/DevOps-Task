
resource "aws_ecr_repository" "ecr_repo" {
  name                 = "${var.name}-${var.env}"
  image_tag_mutability = "MUTABLE"

}


resource "aws_ecr_lifecycle_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.ecr_repo.name
  policy     = <<EOF
    {
    "rules" : [{
        "rulePriority" : 1,
        "description"  : "keep last 10 images",
        "action"       : {
        "type" : "expire"
        },
        "selection"     : {
        "tagStatus"   : "any",
        "countType"   : "imageCountMoreThan",
        "countNumber" : 10
        }
    }]}
    EOF

}

