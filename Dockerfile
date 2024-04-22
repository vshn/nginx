FROM docker.io/nginx:1.25.5-alpine
EXPOSE 8080

# The following lines make this image compatible with OpenShift.
# Source: https://torstenwalter.de/openshift/nginx/2017/08/04/nginx-on-openshift.html
RUN \
    # support running as arbitrary user which belongs to the root group
    chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && \
    # comment user directive as master process is run as different user anyhow
    sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

# Copy the nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

USER 1001:0
