#!/bin/bash

# Set the new version and control plane node names
NEW_VERSION=<new-version>
CONTROL_PLANE_NODES=(<node1> <node2> <node3>)

# Upgrade the control plane nodes
for node in "${CONTROL_PLANE_NODES[@]}"; do
  echo "Upgrading control plane node: $node"
  kubectl drain "$node" --ignore-daemonsets
  ssh "$node" "sudo apt-get update && sudo apt-get install -y kubelet=$NEW_VERSION-00 kubeadm=$NEW_VERSION-00"
done

# Upgrade the control plane components
echo "Upgrading control plane components"
kubeadm upgrade apply "$NEW_VERSION"

# Get the list of worker nodes
WORKER_NODES=$(kubectl get nodes -l node-role.kubernetes.io/node= --output=jsonpath='{.items[*].metadata.name}')

# Upgrade the worker nodes
for node in $WORKER_NODES; do
  echo "Upgrading worker node: $node"
  kubectl drain "$node" --ignore-daemonsets
  ssh "$node" "sudo apt-get update && sudo apt-get install -y kubelet=$NEW_VERSION-00 kubeadm=$NEW_VERSION-00"
done

echo "Update complete!"

