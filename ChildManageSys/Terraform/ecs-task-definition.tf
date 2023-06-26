#ecr 리포지토리 참조 
data "aws_ecr_repository" "childmanagesys" {
  name = "childmanagesys" # 실제 ECR 리포지토리 이름으로 교체해야 합니다.
}

#ecs-task_definition 생성
resource "aws_ecs_task_definition" "final-project-ecs" {
  family                   = "final-project-ecs-task-definition"
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 3072

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  requires_compatibilities = ["FARGATE"]
  
  container_definitions = jsonencode([
     {
             "name": "final-project-ecs-task"
             "image": "${data.aws_ecr_repository.childmanagesys.repository_url}:latest" #뒤의 latest 태그 부분은 초기 ECS 구축 후 github action의 ECS Deploy시 태그 정상 활성화
             "cpu": 0
             "portMappings": [
                 {
                     "name": "final-project-ecs-task-80-tcp",
                     "containerPort": 80,
                     "hostPort": 80,
                     "protocol": "tcp",
                     "appProtocol": "http"
                 },
                 {
                     "name": "final-project-ecs-task-4000-tcp",
                     "containerPort": 4000,
                     "hostPort": 4000,
                     "protocol": "tcp",
                     "appProtocol": "http"
                 },
                 {
                     "name": "final-project-ecs-task-22-tcp",
                     "containerPort": 22,
                     "hostPort": 22,
                     "protocol": "tcp",
                     "appProtocol": "http"
                 }
              ],
              "essential": true,
              "environment": [
                {
                    "name": "USERNAME",
                    "value": "${var.db_username}"
                },
                {
                    "name": "HOSTNAME",
                    "value": "${var.db_hostname}"
                },
                {
                    "name": "PASSWORD",
                    "value": "${var.db_password}"
                },
                {
                    "name": "DATABASE",
                    "value": "${var.db_database}"
                }
              ],
              "mountPoints": [],
              "volumesFrom": [],
              "ulimits": [],
              "logConfiguration": {
                  "logDriver": "awslogs",
                  "options": {
                      "awslogs-create-group": "true",
                      "awslogs-group": "/ecs/final-project-ecs-task-definition",
                      "awslogs-region": "ap-northeast-2",
                      "awslogs-stream-prefix": "ecs"
                  }
              }
          }
  ],
  )
}