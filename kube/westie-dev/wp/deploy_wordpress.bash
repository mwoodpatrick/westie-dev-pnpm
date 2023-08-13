helm install bitnami/wordpress -f wp_values.yaml oci://registry-1.docker.io/bitnamicharts/wordpress 2>&1 | tee deploy_wordpress.log
