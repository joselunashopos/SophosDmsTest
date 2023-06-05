stack_name ="init-dmsexcel-stk"

SCRIPT_DIR=$(dirname "$0")
template_file="$SCRIPT_DIR/Template1.yml"

parameters="$SCRIPT_DIR/parameters.json"

aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file" --parameters file://"$parameters" --region "$region" --capabilities CAPABILITY_IAM

aws sts get-caller-identity --query "Account" --output vaccount

bucket = "bucket-dms-excel-$vaccount"

aws s3 mv python.zip s3://"$bucket"
