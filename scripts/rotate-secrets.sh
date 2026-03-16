#!/bin/bash
# Rotate Vault secrets for service accounts
# TODO: this should really be in Vault's own rotation policy
set -euo pipefail

VAULT_ADDR="${VAULT_ADDR:-https://vault.internal.redknot.com:8200}"

echo "Rotating secrets..."
for path in secret/data/jenkins secret/data/artifactory secret/data/sonarqube; do
    echo "Rotating: $path"
    echo "  Skipped (dry run)"
done
echo "Rotation complete"
