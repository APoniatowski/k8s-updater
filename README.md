# Rolling Update of Kubernetes Cluster
This script automates the process of performing a rolling update of a Kubernetes cluster using kubeadm on Ubuntu. It assumes that you have already checked the compatibility of your current configuration with the new version, and that you have the new kubeadm and kubelet packages installed on all nodes.

## Prerequisites
* You must have kubectl and ssh installed on the machine where you will run the script.
* You must have access to the control plane nodes via ssh.
* The new kubeadm and kubelet packages must be installed on all nodes.

## Usage
1. Download the script and make it executable:
``` 
git clone https://github.com/APoniatowski/k8s-updater
chmod +x update-k8s.sh
```

2. Open the script in a text editor and set the following variables:
* `NEW_VERSION`: The new version of Kubernetes that you want to update to.
* `CONTROL_PLANE_NODES`: An array of the names of the control plane nodes.

3. Run the script:
```
./update-k8s.sh
```
The script will update the control plane nodes, the control plane components, and the worker nodes in a rolling fashion, minimizing downtime.

## Tips
It's a good idea to take a backup of your cluster before running the update, in case you need to revert to a previous version. You can use tools such as Velero or Heptio Ark to do this.
Monitor the cluster and your applications during the update process to ensure everything is running smoothly.
Thoroughly test and validate the cluster after the update is complete to ensure everything is functioning as expected.
