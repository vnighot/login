provider "aws" {
  access_key = "AKIA3CBA2PMMBWTWM3LT"
  secret_key = "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"
  region     = "us-east-2"
}

resource "aws_iam_group_membership" "team" {
  name = "Operators Group Membership"
  users = [
  "${aws_iam_user.user_one.name}",
  "${aws_iam_user.demo_user.name}",
			]
  group = "${aws_iam_group.operators_group.name}"
}

resource "aws_iam_group" "operators_group" {
  name = "Operators"
}

resource "aws_iam_user" "user_one" {
  name = "test-user"
}

resource "aws_iam_user" "demo_user" {
  name = "demo_user"
}

resource "aws_iam_group_policy_attachment" "operator-policy" {
  group      = "${aws_iam_group.operators_group.name}"
  policy_arn = "${aws_iam_policy.operators_policy.arn}"
}

resource "aws_iam_policy" "operators_policy" {
  name  = "operators_policy"
  policy = "${file("operators_policy.json")}"
  
}






