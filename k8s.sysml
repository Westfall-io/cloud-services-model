// This model uses the draw.io definitions of Kubernetes parts
library package Kubernetes {
    part def 'Application Programming Interface';
    alias API for 'Application Programming Interface';

    part def ConfigMap {
        doc /* A ConfigMap is an API object used to store non-confidential 
        data in key-value pairs. Pods can consume ConfigMaps as environment 
        variables, command-line arguments, or as configuration files in a 
        volume.

        A ConfigMap allows you to decouple environment-specific configuration 
        from your container images, so that your applications are easily 
        portable.
        
        See: https://kubernetes.io/docs/concepts/configuration/configmap/ */
    }
    alias CM for ConfigMap;

    part def 'Control Plane' {
        doc /* The control plane's components make global decisions about the 
        cluster (for example, scheduling), as well as detecting and responding 
        to cluster events (for example, starting up a new pod when a 
        Deployment's replicas field is unsatisfied).

        Control plane components can be run on any machine in the cluster. 
        However, for simplicity, setup scripts typically start all control 
        plane components on the same machine, and do not run user containers 
        on this machine. See Creating Highly Available clusters with kubeadm 
        for an example control plane setup that runs across multiple machines.

        See: https://kubernetes.io/docs/concepts/architecture/#control-plane-components
        */

        part def 'Cloud Controller Manager' {
            doc /* Cloud infrastructure technologies let you run Kubernetes on 
            public, private, and hybrid clouds. Kubernetes believes in automated, 
            API-driven infrastructure without tight coupling between components.

            The cloud-controller-manager is a Kubernetes control plane component 
            that embeds cloud-specific control logic. The cloud controller manager 
            lets you link your cluster into your cloud provider's API, and separates 
            out the components that interact with that cloud platform from 
            components that only interact with your cluster.

            By decoupling the interoperability logic between Kubernetes and the 
            underlying cloud infrastructure, the cloud-controller-manager component 
            enables cloud providers to release features at a different pace compared 
            to the main Kubernetes project.

            The cloud-controller-manager is structured using a plugin mechanism 
            that allows different cloud providers to integrate their platforms with 
            Kubernetes. 
            
            See: https://kubernetes.io/docs/concepts/architecture/cloud-controller/
            */
        }
        alias 'C-C-M' for 'Cloud Controller Manager';

        part def 'Controller Manager' {
            doc /* Control plane component that runs controller processes.

            Logically, each controller is a separate process, but to reduce 
            complexity, they are all compiled into a single binary and run in a 
            single process.

            There are many different types of controllers. Some examples of them are:

                - Node controller: Responsible for noticing and responding when nodes 
                go down.
                - Job controller: Watches for Job objects that represent one-off tasks, 
                then creates Pods to run those tasks to completion.
                - EndpointSlice controller: Populates EndpointSlice objects (to 
                provide a link between Services and Pods).
                - ServiceAccount controller: Create default ServiceAccounts for new 
                namespaces.

            The above is not an exhaustive list.

            See: https://kubernetes.io/docs/concepts/architecture/#kube-controller-manager
            */
        }
        alias 'C-M' for 'Controller Manager';
        alias 'kube-controller-manager' for 'Controller Manager';
    }

    part def 'Role-based Access Control' {
        doc /* Role-based access control (RBAC) is a method of regulating 
        access to computer or network resources based on the roles of 
        individual users within your organization.

        RBAC authorization uses the rbac.authorization.k8s.io API group to 
        drive authorization decisions, allowing you to dynamically configure 
        policies through the Kubernetes API.

        See: https://kubernetes.io/docs/reference/access-authn-authz/rbac/
        */

        part def 'Cluster Role' {
            doc /* An RBAC Role or ClusterRole contains rules that represent a 
            set of permissions. Permissions are purely additive (there are no "deny" 
            rules).

            A Role always sets permissions within a particular namespace; when 
            you create a Role, you have to specify the namespace it belongs in.

            ClusterRole, by contrast, is a non-namespaced resource. The resources 
            have different names (Role and ClusterRole) because a Kubernetes 
            object always has to be either namespaced or not namespaced; it can't 
            be both.

            ClusterRoles have several uses. You can use a ClusterRole to:

                - define permissions on namespaced resources and be granted access 
                within individual namespace(s)
                - define permissions on namespaced resources and be granted access 
                across all namespaces
                - define permissions on cluster-scoped resources

            If you want to define a role within a namespace, use a Role; if 
            you want to define a role cluster-wide, use a ClusterRole.

            See: https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole
            */
        }
        alias 'C-Role' for 'Cluster Role';

        part def 'Cluster Role Binding';
        alias CRB for 'Cluster Role Binding';
    }

    part def 'Custom Resource Definition' {
        doc /* The CustomResourceDefinition API resource allows you to define 
        custom resources. Defining a CRD object creates a new custom resource 
        with a name and schema that you specify. The Kubernetes API serves and 
        handles the storage of your custom resource. The name of the CRD object 
        itself must be a valid DNS subdomain name derived from the defined 
        resource name and its API group; see how to create a CRD for more 
        details. Further, the name of an object whose kind/resource is defined 
        by a CRD must also be a valid DNS subdomain name.

        This frees you from writing your own API server to handle the custom 
        resource, but the generic nature of the implementation means you have 
        less flexibility than with API server aggregation.

        See: https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions
        */
    }
    alias CRD for 'Custom Resource Definition';

    part def CronJob {
        doc /* A CronJob creates Jobs on a repeating schedule.

        CronJob is meant for performing regular scheduled actions such as 
        backups, report generation, and so on. One CronJob object is like 
        one line of a crontab (cron table) file on a Unix system. It runs a 
        Job periodically on a given schedule, written in Cron format.

        CronJobs have limitations and idiosyncrasies. For example, in certain 
        circumstances, a single CronJob can create multiple concurrent Jobs. 
        See the limitations below.

        When the control plane creates new Jobs and (indirectly) Pods for a 
        CronJob, the .metadata.name of the CronJob is part of the basis for 
        naming those Pods. The name of a CronJob must be a valid DNS subdomain 
        value, but this can produce unexpected results for the Pod hostnames. 
        For best compatibility, the name should follow the more restrictive 
        rules for a DNS label. Even when the name is a DNS subdomain, the name 
        must be no longer than 52 characters. This is because the CronJob 
        controller will automatically append 11 characters to the name you 
        provide and there is a constraint that the length of a Job name is 
        no more than 63 characters.

        See: https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/
        */
    }

    part def Deployment {
        doc /* A Deployment manages a set of Pods to run an application 
        workload, usually one that doesn't maintain state.

        A Deployment provides declarative updates for Pods and ReplicaSets.

        You describe a desired state in a Deployment, and the Deployment 
        Controller changes the actual state to the desired state at a 
        controlled rate. You can define Deployments to create new ReplicaSets, 
        or to remove existing Deployments and adopt all their resources with 
        new Deployments.

        See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
        */
    }
    alias Deploy for Deployment;

    part def DaemonSet {
        doc /* A DaemonSet defines Pods that provide node-local facilities. 
        These might be fundamental to the operation of your cluster, such as 
        a networking helper tool, or be part of an add-on.

        A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. 
        As nodes are added to the cluster, Pods are added to them. As nodes 
        are removed from the cluster, those Pods are garbage collected. 
        Deleting a DaemonSet will clean up the Pods it created.

        Some typical uses of a DaemonSet are:

            - running a cluster storage daemon on every node
            - running a logs collection daemon on every node
            - running a node monitoring daemon on every node

        In a simple case, one DaemonSet, covering all nodes, would be used 
        for each type of daemon. A more complex setup might use multiple 
        DaemonSets for a single type of daemon, but with different flags 
        and/or different memory and cpu requests for different hardware 
        types.
        
        See: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/ 
        */
    }
    alias DS for DaemonSet;

    part def EndpointSlice {
        doc /* In Kubernetes, an EndpointSlice contains references to a set of 
        network endpoints. The control plane automatically creates EndpointSlices 
        for any Kubernetes Service that has a selector specified. These 
        EndpointSlices include references to all the Pods that match the Service 
        selector. EndpointSlices group network endpoints together by unique 
        combinations of IP family, protocol, port number, and Service name. The 
        name of a EndpointSlice object must be a valid DNS subdomain name.
        
        See: https://kubernetes.io/docs/concepts/services-networking/endpoint-slices/
        */
    }
    alias EP for EndpointSlice;
    alias Endpoint for EndpointSlice;

    part def ECTD;
    part def Group;

    part def 'Horizontal Pod Autoscaling' {
        doc /* In Kubernetes, a HorizontalPodAutoscaler automatically updates 
        a workload resource (such as a Deployment or StatefulSet), with the aim 
        of automatically scaling the workload to match demand.

        Horizontal scaling means that the response to increased load is to 
        deploy more Pods. This is different from vertical scaling, which for 
        Kubernetes would mean assigning more resources (for example: memory or 
        CPU) to the Pods that are already running for the workload.

        If the load decreases, and the number of Pods is above the configured 
        minimum, the HorizontalPodAutoscaler instructs the workload resource 
        (the Deployment, StatefulSet, or other similar resource) to scale 
        back down.

        Horizontal pod autoscaling does not apply to objects that can't be 
        scaled (for example: a DaemonSet.)

        The HorizontalPodAutoscaler is implemented as a Kubernetes API resource 
        and a controller. The resource determines the behavior of the 
        controller. The horizontal pod autoscaling controller, running within 
        the Kubernetes control plane, periodically adjusts the desired scale of 
        its target (for example, a Deployment) to match observed metrics such 
        as average CPU utilization, average memory utilization, or any other 
        custom metric you specify.
        
        See: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
        */
    }
    alias HPA for 'Horizontal Pod Autoscaling';
    part def ING;
    part def Job;
    part def 'K-proxy';
    part def Kubelet;
    part def Limits;
    part def Netpol;
    part def Node;

    part def Namespace {
        doc /* In Kubernetes, namespaces provide a mechanism for isolating 
        groups of resources within a single cluster. Names of resources need 
        to be unique within a namespace, but not across namespaces. Namespace-based 
        scoping is applicable only for namespaced objects (e.g. Deployments, 
        Services, etc.) and not for cluster-wide objects (e.g. StorageClass, 
        Nodes, PersistentVolumes, etc.).
        
        See: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
        */
    }
    alias NS for Namespace;

    part def Pod;
    part def PSP;
    part def PV;
    part def PVC;
    part def Quota;
    part def RB;
    part def Role;
    part def RS;
    part def SA;
    part def SC;
    part def Sched;
    part def Secret;
    part def STS;
    part def SVC;
    part def User;
    
    part def Volume {
        doc /* Kubernetes volumes provide a way for containers in a pod to 
        access and share data via the filesystem. There are different kinds 
        of volume that you can use for different purposes, such as:

            - populating a configuration file based on a ConfigMap or a 
            Secret
            - providing some temporary scratch space for a pod
            - sharing a filesystem between two different containers in the 
            same pod
            - sharing a filesystem between two different pods (even if those 
            Pods run on different nodes)
            - durably storing data so that it stays available even if the 
            Pod restarts or is replaced
            - passing configuration information to an app running in a 
            container, based on details of the Pod the container is in (for 
            example: telling a sidecar container what namespace the Pod is 
            running in)
            - providing read-only access to data in a different container image

        Data sharing can be between different local processes within a 
        container, or between different containers, or between Pods.

        See: https://kubernetes.io/docs/concepts/storage/volumes/
        */
    }
    part def Vol;
}