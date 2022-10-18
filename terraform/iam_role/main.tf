# [var.name]ロールに信頼ポリシーを紐付ける
resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# [var.name]ポリシーに[var.policy]ポリシードキュメントを紐付ける
resource "aws_iam_policy" "this" {
  name   = var.name
  policy = var.policy
}

# [aws_iam_role]と[aws_iam_policy]を紐付ける
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
