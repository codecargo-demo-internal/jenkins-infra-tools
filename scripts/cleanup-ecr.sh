#!/bin/bash
# Clean up untagged images older than 30 days from ECR
# Run weekly via Jenkins cron job
set -euo pipefail

REPOS=$(aws ecr describe-repositories --query 'repositories[].repositoryName' --output text)

for repo in $REPOS; do
    echo "Cleaning $repo..."
    aws ecr describe-images \
        --repository-name "$repo" \
        --filter tagStatus=UNTAGGED \
        --query 'imageDetails[?imagePushedAt<`'$(date -d '30 days ago' --iso-8601)'`].imageDigest' \
        --output text | while read -r digest; do
            if [ -n "$digest" ]; then
                aws ecr batch-delete-image --repository-name "$repo" --image-ids imageDigest="$digest"
            fi
        done
done
echo "ECR cleanup complete"
