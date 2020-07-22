# Running RMS Applications in AWS Based Kubernetes

To use TIBCO BusinessEvents® WebStudio in Kubernetes cluster, you must set up TIBCO BusinessEvents and Rule Management Server \(RMS\) in AWS based Kubernetes.

-   Docker image of TIBCO BusinessEvents application, see [Building TIBCO BusinessEvents Application Docker Image](Building%20TIBCO%20BusinessEvents%20Application%20Docker%20Image).
-   Download and install the following CLIs on your system:

    |CLI|Download and Installation Instruction Link|
    |---|------------------------------------------|
    |`kops`|https://github.com/kubernetes/kops/blob/master/docs/aws|
    |`kubectl`|https://kubernetes.io/docs/tasks/tools/install-kubectl/|
    |`aws`|https://aws.amazon.com/cli/|


1.  Set up a Kubernetes cluster on Amazon Web Services \(AWS\). For more information, see [Setting up a Kubernetes Cluster on AWS](Setting%20up%20a%20Kubernetes%20Cluster%20in%20AWS).

2.  In AWS, create an EFS file system.

    For more information on the steps to create an EFS file system, see [Amazon EFS documentation](https://docs.aws.amazon.com/efs/latest/ug/gs-step-two-create-efs-resources.html). Specify the Kubernetes cluster Virtual Private Cloud \(**VPC**\) and **Security Group** while creating a mount target for the file system. On the File Systems page, verify that the mount target shows the **Life Cycle State** as Available. Under **File system access**, you see the file system **DNS name**. Make a note of this DNS name.

    After successful creation of the EFS file system, note its **File System ID**, which can be used for creating EFS provisioner.

3.  Create the EFS provisioner and other associated resources. Specify all the connection setup values for the EFS file system in a manifest.yaml file and run the `kubectl` command to create the EFS provisioner.

    1.  Download the sample manifest.yaml file from [https://raw.githubusercontent.com/kubernetes-incubator/external-storage/master/aws/efs/deploy/manifest.yaml](https://raw.githubusercontent.com/kubernetes-incubator/external-storage/master/aws/efs/deploy/manifest.yaml) and edit it according to your setup.

    2.  In the `configmap` section, specify **File System ID** of the newly created EFS as the value of the `file.system.id:` variable and **Availability Zone** of the newly created EFS as the value of the `aws.region:` variables.

    3.  In the `Deployment` section, specify DNS name of the newly created EFS as the value of the `server:` variable.

    4.  Run the `kubectl` command to apply the settings in manifest.yaml.

        ```
        kubectl apply -f manifest.yaml
        ```

    5.  Ensure that the EFS provisioner pod is in the running state using the `kubectl` command.

        ```
        kubectl get pods
        ```

4.  As RMS is running in a Docker container, separate external storage must be set up for required files and artifacts. For this, create EFS based `PersistentVolumeClaim` \(PVC\) using the configuration files \(YAML format\).

    The sample YAML file`berms-efs-persistent-volume-claims.yaml` for creating storage class and PVCs is located at BE_HOME\cloud\kubernetes\AWS\rms. The `berms-efs-persistent-volume-claims.yaml` file set up the following PVC:

    |PVC Name|Description|
    |--------|-----------|
    |`efs-webstudio`|Set up the PVC for storing TIBCO BusinessEvents project files.|
    |efs-security|Set up the PVC for storing TIBCO BusinessEvents project ACL files, such as, `CreditCardApplication.ac`.|
    |`efs-shared`|Set up the PVC for storing RMS artifacts after hot deployment, such as, rule template instances.|
    |`efs-notify`|Set up the PVC for storing Email notification files, such as, `message.stg`.|

    For more information about the Kubernetes object spec files, see [Kubernetes documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/).

5.  Run the `create` command of `kubectl` utility using the YAML files to create PVCs on the EFS file system.

    For example, create PVCs using the sample files:

    ```
    kubectl create -f berms-efs-persistent-volume-claims.yaml
    ```

6.  Mount the EFS file system into the Kubernetes EC2 instance nodes.

    For more information on how to mount EFS file system on EC2 instance, refer AWS Documentation at [https://docs.aws.amazon.com/efs/latest/ug/mounting-fs.html](https://docs.aws.amazon.com/efs/latest/ug/mounting-fs.html).

    After successful mounting, PVCs on EFS are available for uploading files.

7.  Transfer files from your system to the respective PVCs.

    -   RMS project files \(for example, project files at BE_HOME\examples\standard\WebStudio\\) to the project storage PVC \(`efs-webstudio`\)
    -   RMS security files and project access control \(`.ac`\) files at BE_HOME\rms\config\security to the security storage PVC \(`efs-security`\).
    -   RMS notification related files \(for example, `message.stg` at BE_HOME\rms\config\notify\) to the notify storage PVC \(`efs-notify`\).
    For information on how to transfer files from your system to EC2 instance, refer to the *Amazon AWS Documentation* at [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html).

8.  Build the RMS Docker image for deploying to Kubernetes.

    For every project add JMX configuration in RMS.cdd, for example:

    ```
     <property name="*ProjectName*.ws.applicableEnvironments" type="string" value="QA,PROD"/>
     <property name="*ProjectName*.QA.ws.jmx.hotDeploy.enable" type="boolean" value="true"/>
    ** <property name="*ProjectName*.QA.ws.jmx.host" type="string" value="bejmx-service.default.svc.cluster.local"/>**
     **<property name="*ProjectName*.QA.ws.jmx.port" type="integer" value="5555"/>**
     <property name="*ProjectName*.QA.ws.jmx.user" type="string" value=""/>
     <property name="*ProjectName*.QA.ws.jmx.password" type="string" value=""/>
     <property name="*ProjectName*.QA.ws.jmx.clusterName" value="CreditCardApplication"/>
     <property name="*ProjectName*.QA.ws.jmx.agentName" value="inference-class"/>
    ```

    For every project configure `jmx.host` as the fully qualified name \(FQN\) of the local JMX Kubernetes service defined earlier, for example, `bejmx-service.default.svc.cluster.local`. Also, for every project configure `jmx.port` as the JMX port number defined in the JMX Kubernetes service, for example, `5555`.

9.  Create RMS Docker image. For more information, see [Building RMS Docker Image](Building%20RMS%20Docker%20Image#).

10. Go to the EC2 Container Services dashboard and create a repository with the same name as the RMS Docker image. Upload the RMS image to the repository. You can use the **View Push Commands** button to view how to do that.

    **Note:** AWS Repository name should be same as the RMS Docker image.

    For more information on how to create a repository in Amazon AWS, refer to [https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html).

11. Define an internal JMX Kubernetes service using the supplied sample YAML configuration file bejmx-service.yaml.

    RMS server uses this service to connect to the JMX port of a BusinessEvents pod.

12. Create other Kubernetes object specification \(`.yaml`\) files based on your deployment requirement.

    These resources include deployment and services for the cluster. Thus, to deploy a BusinessEvents cluster, create the following YAML files:

    -   Discovery node \(pod\) to start the cluster.
    -   Service to connect to the discovery node.
    -   Cache agent node that connects to the discovery node service.
    -   Inference agent node that connects to the discovery node service.
    -   Service to connect to the inference agent.
    -   RMS node containing RMS docker image.
    -   External service to connect to the RMS node.
    For details about describing a Kubernetes object in a YAML file, see [Kubernetes documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/). For details about the sample YAML files, see [Sample Kubernetes YAML Files for RMS](Sample%20Kubernetes%20Resource%20YAML%20Files%20for%20RMS#).

13. Create Kubernetes objects required for deploying and running the application and RMS by using the object specification \(`.yaml`\) files.

    For example, create the Kubernetes objects by using the sample YAML files mentioned in [Sample Kubernetes YAML Files for RMS](Sample%20Kubernetes%20Resource%20YAML%20Files%20for%20RMS#):

    ```
    kubectl create -f bejmx-service.yaml
    
    kubectl create -f berms.yaml
    
    kubectl create -f berms-service.yaml
    
    kubectl create -f bediscoverynode.yaml
    
    kubectl create -f bediscovery-service.yaml
    
    kubectl create -f becache.yaml
    
    kubectl create -f beinferenceagent.yaml
    
    kubectl create -f beinference-service.yaml
    ```



14. \(Optional\) If required, you can check logs of TIBCO BusinessEvents pod.

    **Syntax**:

    ```
    kubectl logs <pod>
    ```

    For example, use the `kubectl get` command to get the list of pods and then use the `kubectl logs` command to view logs of `bediscoverynode`.

    ```
    kubectl get pods
    
    kubectl logs bediscoverynode-86d75d5fbc-z9gqt
    ```

15. Get the external IP of your application which you can use to connect to the cluster.

    **Syntax**:

    ```
    kubectl get services <external_service_name>
    ```

    For example,

    ```
    kubectl get services berms-service
    ```


Use the IP obtained to connect to TIBCO BusinessEvents WebStudio from your browser.

**Parent topic:**[TIBCO BusinessEvents on AWS Based Kubernetes](TIBCO%20BusinessEvents%20on%20AWS%20Based%20Kubernetes)

**Related information**  


[Running TIBCO BusinessEvents® on AWS Based Kubernetes Cluster](Running%20BusinessEvents%20Applications%20in%20Kubernetes)

[Monitoring TIBCO BusinessEvents Applications on AWS](Monitoring%20TIBCO%20BusinessEvents%20Applications%20on%20AWS)

