# Volume mounter

This pod mounts an existing EBS volume for troubleshooting. Unlike new volumes, this template works with volumes you already created but need to inspect without attaching to a full application.

## Configuration Hints

**Volume ID**: Your EBS volume (e.g., vol-12345). Check with: `aws ec2 describe-volumes`

**Zone**: Must match volume's actual availability zone. Mismatched zones prevent volume attachment.

**Storage class**: Determines volume type (gp3, gp2, standard). Check available classes in your cluster.

**Capacity**: Requested size for PVC. Can be smaller than actual volume size.

## Usage

1. Update the values in `volume-mounter.yaml`. Volume ID, zone, capacity, storage class, etc.

    ```shell
    vim volume-mounter.yaml
    ```

2. Apply the mounter

    ```shell
    kubectl apply -f volume-mounter.yaml
    ```

3. Shell into the pod and access the filesystem on the volume.

## Cleanup

```sh
kubectl delete -f volume-mounter.yaml
```

This deletes the pod but NOT the PersistentVolume. The volume remains untouched for safety.

**Gotcha**: If pod won't start, check zone matches volume's zone, storage class exists, and volume isn't attached elsewhere.
