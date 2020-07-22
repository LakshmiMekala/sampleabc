# TIBCO BusinessEvents on Pivotal Based Kubernetes

You can run any TIBCO BusinessEvents application on a Pivotal based Kubernetes cluster and monitor the application by using TIBCO BusinessEvents Enterprise Administrator Agent. You can also manage your business rules in TIBCO BusinessEvents WebStudio by running RMS on the Pivotal based Kubernetes cluster.

You can use Enterprise Pivotal Container Service \(PKS\) on Google Cloud Platform \(GCP\) to deploy applications on Kubernetes. For details, see "Enterprise Pivotal Container Service" in [Pivotal Docs](https://docs.pivotal.io/pks).

## Readme for Sample Applications

TIBCO BusinessEvents provides readme.html files to run the sample applications on a Pivotal based Kubernetes cluster by using [Enterprise PKS](https://docs.pivotal.io/pks) on [GCP](https://cloud.google.com/docs/). To run your application, RMS, and TIBCO BusinessEvents Enterprise Administrator Agent by using sample YAML files, follow the instructions given in the readme.html files.

The following table lists common scenarios and location of respective readme.html and sample YAML files for running sample applications and other components:

|Scenario|readme.html and Sample YAML Files Location|
|--------|------------------------------------------|
|Running a TIBCO BusinessEvents application \(FraudDetection\) without cache|BE_HOME\cloud\kubernetes\PKS\inmemory|
|Running a TIBCO BusinessEvents application \(FraudDetectionCache and FraudDetectionStore\) with cache|BE_HOME\cloud\kubernetes\PKS\cache|
|Running TIBCO BusinessEvents WebStudio|BE_HOME\cloud\kubernetes\PKS\rms|
|Running TIBCO BusinessEvents Enterprise Administration Agent for monitoring TIBCO BusinessEvents applications|BE_HOME\cloud\kubernetes\PKS\tea|

## Topics

-   [Running an Application in Enterprise PKS Installed on GCP](Running%20an%20Application%20in%20PKS%20Installed%20on%20GCP)
-   [Monitoring TIBCO BusinessEvents Applications on Enterprise PKS](Monitoring%20TIBCO%20BusinessEvents%20Applications%20on%20Enterprise%20PKS)
-   [Running RMS on Enterprise PKS](Running%20RMS%20on%20Enterprise%20PKS)

-   **[Running an Application in Enterprise PKS Installed on GCP](Running%20an%20Application%20in%20PKS%20Installed%20on%20GCP)**  
 By using Enterprise PKS installed on GCP, you can deploy a TIBCO BusinessEvents application in the Kubernetes cluster managed by Enterprise PKS.
-   **[Monitoring TIBCO BusinessEvents Applications on Enterprise PKS](Monitoring%20TIBCO%20BusinessEvents%20Applications%20on%20Enterprise%20PKS)**  
To monitor TIBCO BusinessEvents applications running on Enterprise PKS, run TIBCO BusinessEvents Enterprise Administrator Agent container in the same Kubernetes namespace as the application.
-   **[Running RMS on Enterprise PKS](Running%20RMS%20on%20Enterprise%20PKS)**  
 To use TIBCO BusinessEvents WebStudio on Pivotal, you must set up TIBCO BusinessEvents and Rule Management Server \(RMS\) on Pivotal by using Enterprise PKS.

