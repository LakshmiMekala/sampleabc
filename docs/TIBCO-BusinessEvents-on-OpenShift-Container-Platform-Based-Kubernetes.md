
You can run any TIBCO BusinessEvents application on OpenShift Container Platform based Kubernetes cluster and monitor them by using TIBCO BusinessEvents Enterprise Administrator Agent. You can also manage business rules through WebStudio by running RMS on OpenShift Container Platform based Kubernetes cluster.

For details, see [OpenShift Container Platform documentation](https://docs.openshift.com/container-platform).

## Readme for Sample Applications

TIBCO BusinessEvents provides readme.html files to help you in running the sample applications and components on OpenShift Container Platform. You can follow the instruction in the readme.html file to run the application, WebStudio, and TIBCO BusinessEvents Enterprise Administrator Agent by using the provided sample YAML files.

The following table lists location of readme.html and sample YAML files for running sample applications and other components:

| Scenario                                                     | readme.html and Sample YAML Files Location       |
| ------------------------------------------------------------ | ------------------------------------------------ |
| Running TIBCO BusinessEvents application \(FraudDetection\) without cache on OpenShift Container Platform | `BE_HOME\cloud\kubernetes\OpenShift\inmemory` |
| Running TIBCO BusinessEvents applications \(FraudDetectionCache and FraudDetectionStore\) with cache on OpenShift Container Platform | `BE_HOME\cloud\kubernetes\OpenShift\cache`    |
| Running TIBCO BusinessEvents WebStudio on OpenShift Container Platform | `BE_HOME\cloud\kubernetes\OpenShift\rms`      |
| Running TIBCO BusinessEvents Enterprise Administration Agent for monitoring TIBCO BusinessEvents applications on OpenShift Container Platform | `BE_HOME\cloud\ubernetes\OpenShift\tea`      |

## Topics


-   **[Running an Application on OpenShift Based Kubernetes Cluster](Running%20an%20Application%20on%20OpenShift%20Container%20Platform%20Based%20Kubernetes%20Cluster)**  
     By using Red Hat OpenShift Container Platform, you can deploy a TIBCO BusinessEvents application in the Kubernetes cluster managed in an on-premises infrastructure.
-   **[Monitoring TIBCO BusinessEvents Applications on OpenShift Container Platform](Monitoring%20TIBCO%20BusinessEvents%20Applications%20on%20OpenShift%20Container%20Platform)**  
    To monitor TIBCO BusinessEvents applications running on OpenShift Container Platform based Kubernetes, run TIBCO BusinessEvents Enterprise Administrator Agent container in the same Kubernetes namespace.
-   **[Running the RMS on OpenShift Container Platform](Running%20the%20RMS%20on%20OpenShift%20Container%20Platform)**  
    To use TIBCO BusinessEvents WebStudio in OpenShift Container Platform, you must set up TIBCO BusinessEvents and Rule Management Server \(RMS\) in OpenShift Container Platform based Kubernetes.

