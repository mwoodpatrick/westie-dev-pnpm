# https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/
export MYSQL_DATABASE=wp-test
export MYSQL_USER=root
export MYSQL_PASSWORD=mysql_password
export WP_ADMIN_USER=wp_admin_user23
export WP_ADMIN_PASSWORD=wordpress
kubectl apply -k ./
kubectl get secrets
kubectl get pvc
kubectl get pods
kubectl get svc
kube service wordpress --url
