resource "aws_eks_cluster" "aka-eks-cluster" {
name = "aka-eks-cluster"

vpc_config {
    subnet_ids = aws_subnet.aka-subnets[*].id
}
role_arn = aws_iam_role.aka-role.arn

depends_on = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy]

}
