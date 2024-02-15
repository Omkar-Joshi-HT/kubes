#!/bin/bash

# Define variables
USERNAME="Omkar-Joshi-HT"
REPO="web-app"
TOKEN="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" 
IMAGE_PATCH_FILE="overlays/dev/image-patch.yaml"

# Fetch the latest commit ID from GitHub API
latest_commit=$(curl -s -H "Authorization: token $TOKEN" \
                    "https://api.github.com/repos/$USERNAME/$REPO/commits/main" | \
                    jq -r '.sha')

# Update the image tag in the image-patch.yaml file using yq
yq e -i ".spec.template.spec.containers[0].image = \"public.ecr.aws/n2d8l6y5/web-app:$latest_commit\"" $IMAGE_PATCH_FILE

echo "Updated image tag to: $latest_commit"
