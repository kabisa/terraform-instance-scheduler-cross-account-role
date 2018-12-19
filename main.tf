resource "aws_iam_role_policy" "this" {
  count = "${var.enable_instance_scheduler_cross_account_role ? 1 : 0}"
  name = "InstanceSchedulerCrossAccountPolicy"
  role = "${aws_iam_role.this.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:DescribeInstances",
                "ec2:StartInstances",
                "ec2:StopInstances",
                "ec2:ModifyInstanceAttribute",
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "rds:DescribeDBInstances",
                "rds:DescribeDBSnapshots",
                "rds:StartDBInstance",
                "rds:StopDBInstance",
                "rds:AddTagsToResource",
                "rds:RemoveTagsFromResource",
                "rds:DeleteDBSnapshot"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "tag:GetResources"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role" "this" {
  count = "${var.enable_instance_scheduler_cross_account_role ? 1 : 0}"
  
  name = "InstanceSchedulerCrossAccountRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_master_account_id}:root",
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
