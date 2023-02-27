env_var_list="AWS_S3_BUCKET AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION";
for v in $env_var_list; do
	if [ -z "${!v}" ]; then
  	echo "$v is not set. Quitting."
  	exit 1
	fi
done

aws configure --profile s3-synchro <<-EOF 
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF
aws s3 sync ${SRC:-.} s3://${AWS_S3_BUCKET}/${DST} --profile s3-synchro

