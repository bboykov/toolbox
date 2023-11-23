# Volume mounter

A template to mount a volume in Kubernetes for troubleshooting, cleanup, etc.

## Usage

1. Update the values in `volume-mounter.yaml`. Volume ID, zone, capacity, storage class, etc.

    ```shell
    vim volume-mounter.yaml
    ```

1. Apply the mounter

    ```shell
    kubectl apply -f volume-mounter.yaml
    ```

1. shell into the pod and access the filesystem on the volume.
