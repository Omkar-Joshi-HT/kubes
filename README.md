# Kustomize: A tool for customizing Kubernetes YAML files

Kustomize is a native Kubernetes configuration management tool that simplifies the customization of Kubernetes YAML files without the need for templating engines like Helm. It allows you to define overlays to apply specific configurations for different environments, manage resource patches, and maintain a clean separation of concerns in your Kubernetes manifests.
```
 kubectl kustomize overlays/dev/
```
```
kubectl apply -k overlays/dev/
```
# Install Argo CD and its dependencies
 Create a dedicated namespace for Argo CD
```
kubectl create namespace argocd
```
 Apply the installation manifests from the stable branch
```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
# Interact with Argo CD UI
 Retrieve the service information
```
kubectl get svc -n argocd
```
 Forward the port to access the Argo CD UI locally
```
kubectl port-forward service/argocd-server -n argocd 8080:443
```
 Log in to Argo CD with initial admin password from Kubernetes secrets and decode it
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
# Create an application using terminal
```
argocd app create kustom-webapp-prod \
--repo https://github.com/Omkar-Joshi-HT/kubes.git \
--path kustomized-webappa/overlays/prod \
--dest-server https://kubernetes.default.svc \
--dest-namespace prod 
```
# Kustomize Commands:
```
kustomize build <path>                   # Produce a customized set of Kubernetes manifests from a directory or URL.
kustomize create <name>                  # Create a new kustomization directory with a given name.
kustomize edit <path>                    # Open the kustomization file for editing.
kustomize edit add <field>               # Add a field to the kustomization file.
kustomize edit set <field>               # Set a field in the kustomization file.
kustomize edit remove <field>            # Remove a field from the kustomization file.
kustomize build . | kubectl apply -f -   # Build and apply the customized Kubernetes manifests directly.
```
# Argo CD Command Cheat Sheet:
```
argocd app create                  # Create a new Argo CD application.
argocd app list                    # List all applications in Argo CD.
argocd app logs <appname>          # Get the application’s log output.
argocd app get <appname>           # Get information about an Argo CD application.
argocd app diff <appname>          # Compare the application’s configuration to its source repository.
argocd app sync <appname>          # Synchronize the application with its source repository.
argocd app history <appname>       # Get information about an Argo CD application.
argocd app rollback <appname>      # Rollback to a previous version
argocd app set <appname>           # Set the application’s configuration.
argocd app delete <appname>        # Delete an Argo CD application.
```
