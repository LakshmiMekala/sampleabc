# Setting Up a Kubernetes Cluster with Enterprise PKS

In Pivotal, you can use Enterprise PKS to create and manage a Kubernetes cluster. Use the Enterprise PKS Command Line Interface \(PKS CLI\) to deploy the Kubernetes cluster and manage its lifecycle. To deploy and manage container-based workloads on the Kubernetes cluster, use the Kubernetes CLI \(`kubectl`\).

-   Enterprise PKS installed on GCP. For details, see "Enterprise Pivotal Container Service" in [Pivotal Docs](https://docs.pivotal.io/pks).
-   Download and install the following CLIs on your system:

    |CLI|Download and Installation Reference|
    |---|-----------------------------------|
    |Enterprise PKS CLI \(`pks`\)|"Installing the PKS CLI" in [Pivotal Docs](https://docs.pivotal.io/pks)|
    |Kubernetes CLI \(`kubectl`\)|"Installing the Kubernetes CLI" in [Pivotal Docs](https://docs.pivotal.io/pks)|


1.  Create a Kubernetes cluster with PKS CLI.

    See "Managing Clusters" in [Pivotal Docs](https://docs.pivotal.io/pks).

    Sample `pks` command syntax:

    ```
    pks login -a <pks_api> -u <username> -p <password>
    
    pks create-cluster <cluster_name> --external-hostname <hostname> --plan <plan-name> --num-nodes <worker-nodes>
    
    pks cluster <cluster-name> 
    ```

2.  Get access to the Kubernetes cluster for managing it from the Kubernetes CLI.

    Sample `pks` command syntax:

    ```
    pks get-credentials <cluster-name>
    ```

3.  Verify access to the Kubernetes cluster by using the Kubernetes CLI.

    Sample `kubectl` command syntax:

    ```
    kubectl cluster-info
    ```


**Parent topic:**[Running an Application in Enterprise PKS Installed on GCP](Running%20an%20Application%20in%20PKS%20Installed%20on%20GCP)

