## K8s Commands


### Clusters
Show all contexts
```sh
k config get-contexts
```

How to switch clusters
```sh
k config use-context <new cluster>
```

### Namespaces
Switch namespaces in cluster
```sh
k config set-context --current --namespace <new namespace>
```

Show all namespaces in cluster
```sh
k get ns

# or
k describe ns <ns>
```

### Pods
How to describe a pod
```sh
k describe pod <pod name>
```

How to tail logs of a pod
```sh
k logs --follow <pod name>
```

Open a shell in a pod
```sh
kubectl exec --stdin --tty <pod> -- /bin/bash
```

### Services
```sh
kubectl describe service <service>
```

### Service Accounts
Show service accounts
```sh
k get serviceaccounts

# or as specific service accounts config object
k get serviceaccounts/<service account> -o yaml
```

### Ingresses
Show all ingresses
```sh
k get ingresses
```

Get an ingresses info
```sh
k describe ingress <ingress_name> -n <namespace>
```

### DNS
Get external dns logs
```sh
kubectl logs -f  <external dns>
```


### Articles
Cool article on DNS resolution:
https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/

Cool article on monitoring traffic:
https://medium.com/@ManagedKube/kubernetes-troubleshooting-ingress-and-services-traffic-flows-547ea867b120
