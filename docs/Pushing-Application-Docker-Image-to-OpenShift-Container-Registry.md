To deploy the application, you must push the application Docker image to the OpenShift Container Platform default Docker registry.

**Note:** The following procedure lists sample steps to complete the task. These steps can vary based on your infrastructure setup. For details, see [Red Hat OpenShift Container Platform documentation](https://docs.openshift.com/container-platform).
### Prerequisites
-   You must have the Docker image of your TIBCO BusinessEvents application, see [Building TIBCO BusinessEvents Application Docker Image](Building%20TIBCO%20BusinessEvents%20Application%20Docker%20Image).
-   You must be logged in to OpenShift Container Platform CLI, see [Setting Up the OpenShift CLI Environment](Setting%20Up%20the%20OpenShift%20Container%20Platform%20CLI%20Environment).
### Procedure
1. Get the default Docker registry details of OpenShift Container Platform by using the `oc describe` command.

   ```
   oc describe -n default service/docker-registry
   ```

   The command returns the registry details on the terminal which you can use for pushing the application image. For example:

   ```
   **$ oc describe -n default service/docker-registry**
   Name:              docker-registry
   Namespace:         default
   Labels:            <none>
   Annotations:       <none>
   Selector:          docker-registry=default
   Type:              ClusterIP
   **IP:                192.0.2.0**
   **Port:              5000-tcp  5000/TCP**
   TargetPort:        5000/TCP
   Endpoints:         198.51.100.10:5000
   Session Affinity:  ClientIP
   Events:            <none>
   ```

2. Tag the application Docker image with the OpenShift default Docker registry name and project name.

   Syntax:

   ```
   docker tag <image_name>:<version> <registry_login_server>/<project_name>/<image>:<version>
   ```

   For example,

   ```
   $ docker tag fdcache550:01  192.0.2.0:5000/be-project/fdcache550:01
   ```

3. Login to OpenShift Docker container registry using your OpenShift credentials.

   For example:

   ```
   $ docker login 192.0.2.0:5000 -u userid -p ov40AhpTXYZOwHBtC_vat0SF4xJd8lQNjylccs8ZOLc
   ```

4. Push the tagged application Docker image to the OpenShift Docker container registry.

   Syntax:

   ```
   docker push <registry_login_server>/<project_name>/<image>:<version>
   ```

   For example:

   ```
   $ docker push 192.0.2.0:5000/be-project/fdcache550:01
   ```

**Parent topic:** [Running an Application on OpenShift Based Kubernetes Cluster](Running%20an%20Application%20on%20OpenShift%20Container%20Platform%20Based%20Kubernetes%20Cluster)

**Next topics:**  
* [Running the Application Without Backing Store on OpenShift Container Platform](Running%20the%20Application%20for%20No%20Backing%20Store%20on%20OpenShift%20Container%20Platform)
* [Running the Application with Shared All Persistence on OpenShift Container Platform](Running%20the%20Application%20for%20Shared%20All%20Persistence%20on%20OpenShift%20Container%20Platform)
* [Running the Application with Shared Nothing Persistence on OpenShift Container Platform](Running%20the%20Application%20with%20Shared%20Nothing%20Persistence%20on%20OpenShift%20Container%20Platform)

