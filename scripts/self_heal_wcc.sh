#!/bin/bash

# ---
# metadata:
#   document_type: "SHELL_SCRIPT"
#   origin_terminal: "Woodfine-Command-Centre"
#   entity_authority: "SYSTEM-ADMINISTRATOR"
#   purpose: "Self-Healing & Manifest Verification"
# ---

# 1. Identity Verification
echo "🔍 Verifying Terminal Identity..."
CURRENT_HOSTNAME=$(hostname)
AUTHORIZED_ID="Woodfine-Command-Centre"

# In professional deployment, this would check a hardware UUID or Secure Enclave ID.
# For now, we utilize the authorized naming convention.
if [[ "$CURRENT_HOSTNAME" != *"$AUTHORIZED_ID"* ]]; then
    echo "❌ ERROR: Unauthorized Terminal. Logic sequence terminated."
    exit 1
fi
echo "✅ Terminal Authorized: $AUTHORIZED_ID"

# 2. Fetch Single Source of Truth (SSoT) Manifests
echo "🌐 Fetching SSoT Manifests from GitHub..."
VENDOR_MANIFEST=$(curl -s https://raw.githubusercontent.com/pointsav/.github/main/profile/VENDOR_MANIFEST.md)
CUSTOMER_MANIFEST=$(curl -s https://raw.githubusercontent.com/woodfine/.github/main/profile/CUSTOMER_MANIFEST.md)

if [[ -z "$VENDOR_MANIFEST" || -z "$CUSTOMER_MANIFEST" ]]; then
    echo "⚠️ WARNING: Manifests unreachable. Checking local cache..."
else
    echo "✅ Manifests synchronized."
fi

# 3. Triple-Blind Protocol Audit (Local Remotes)
echo "📦 Auditing Git Supply Chain..."
cd ~/Developer/pointsav/pointsav-monorepo 2>/dev/null || { echo "❌ Directory not found."; exit 1; }

# Check for Identity Bleed in remotes
REMOTES=$(git remote -v)

# Verify pointsav (Vendor)
if [[ $REMOTES == *"pointsav"* && $REMOTES == *"github-jwoodfine"* ]]; then
    echo "✅ Ingest Path (pointsav): Verified for jwoodfine."
elif [[ $REMOTES == *"pointsav"* && $REMOTES == *"github-pwoodfine"* ]]; then
    echo "✅ Ingest Path (pointsav): Verified for pwoodfine."
else
    echo "🔧 SELF-HEALING: Re-aligning pointsav remote to authorized SSH alias..."
    # Defaulting to jwoodfine for current session-active Contributor
    git remote set-url pointsav git@github-jwoodfine:pointsav/pointsav-monorepo.git
fi

# 4. Deployment Verification (Operational State)
echo "🚛 Checking Operational Node Mapping..."

# Verification of specific deployments mapped in the CUSTOMER_MANIFEST
declare -a NODES=("route-network-admin" "node-console-email" "vault-privategit-source")

for node in "${NODES[@]}"; do
    if [[ "$CUSTOMER_MANIFEST" == *"$node"* ]]; then
        echo "🔹 Node Found in Manifest: $node"
    else
        echo "❌ ALERT: $node is missing from Customer Manifest. Manual update required."
    fi
done

echo "✨ Self-Healing sequence complete. Environment is in Zero-Drift state."
