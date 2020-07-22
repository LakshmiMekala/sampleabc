
To run the application in a Kubernetes cluster on OpenShift, you can use OpenShift Container Platform CLI which runs on top of the Kubernetes cluster.

You can download the `oc` client tool from the OpenShift web console and install it to execute OpenShift Container Platform commands. In the OpenShift Container Platform, you can create a new project that defines the scope of resources and who can access those resources. The application images are deployed in a project.

For details about OpenShift Container Platform or any of the steps in the following procedure, see the [Red Hat OpenShift Container Platform documentation](https://docs.openshift.com/container-platform).
### Prerequisites
-   You must have valid subscription of OpenShift Container Platform on your Red Hat account, see [Red Hat OpenShift Container Platform](https://www.openshift.com/products/container-platform).
### Procedure
1. Download and install the `oc` client tool on the master node to access the OpenShift CLI commands.

2. Log in to the OpenShift CLI by using the `oc login` command .

   For example:

   ```
   $ oc login 203.0.113.0:8443 --token=ov40AhpOCBITwHBtC_vat0SF4xJd8lQNjylccs8ZOLc 
   ```

3. Create a new project by using the `oc new-project` command.

   For example:

   ```
   $ oc new-project be-project --description="For running BE applications." --display-name="be-project"
   
   ```

### Result
A new project `be-project` is created and you are its project admin. You can use the `oc status` command to see the status of your projects.


**Parent topic:** [Running an Application on OpenShift Based Kubernetes Cluster](Running%20an%20Application%20on%20OpenShift%20Container%20Platform%20Based%20Kubernetes%20Cluster)

**Next topic:**
[Pushing Application Docker Image to OpenShift Container Registry](Pushing%20Application%20Docker%20Image%20to%20OpenShift%20Container%20Registry)

