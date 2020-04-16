
sudo killall -9 dotnet
nohup dotnet /home/ec2-user/src/HelloWorldWebCore/build_output/HelloWorldWebCore.dll &>/dev/null &
EC2_ASG="$(aws ec2 describe-tags --region="eu-west-3" | jq -r '.Tags[] | select (.Key=="aws:autoscaling:groupName") | .Value')"
EC2_INSTANCE_ID="$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
aws autoscaling complete-lifecycle-action --region="eu-west-3" --lifecycle-action-result CONTINUE \
  --instance-id $EC2_INSTANCE_ID --lifecycle-hook-name LifeCycleHookTest \
  --auto-scaling-group-name $EC2_ASG
