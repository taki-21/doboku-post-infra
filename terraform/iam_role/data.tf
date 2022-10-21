# 信頼ポリシードキュメントの定義 (awsの[var.identifier]サービスにロールを関連づける)
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [var.identifier]
    }
  }
}
