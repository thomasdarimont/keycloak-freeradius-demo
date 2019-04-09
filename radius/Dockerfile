FROM freeradius/freeradius-server:3.0.18

ENV OAUTH_PAM_PREFIX /opt/pam-exec-oauth2
ENV RADIUS_SECRET bubu123

# Note those tools are just used for debugging and could be removed
RUN apt-get update && \
    apt-get install -y less curl jq vim rsyslog

# Install OAuth2 PAM Module
# --chown=freerad:freerad 
COPY --chown=freerad:freerad pam-exec-oauth2 $OAUTH_PAM_PREFIX/pam-exec-oauth2
COPY --chown=freerad:freerad pam-exec-oauth2.yaml $OAUTH_PAM_PREFIX/pam-exec-oauth2.yaml

COPY --chown=freerad:freerad clients.conf /etc/freeradius/clients.conf

# Add OAuth2 PAM Module as allowed login mechanism
RUN echo "Enable PAM module" && \
    cd /etc/freeradius/mods-enabled && \
    ln -s ../mods-available/pam pam && \
    cd / && \
    echo "Enable PAM authentication" && \
    sed -i 's/#\s*pam/	pam/' /etc/freeradius/sites-enabled/default && \
    sed -i 's/#\s*pam/	pam/' /etc/freeradius/sites-enabled/inner-tunnel && \
    echo "Enable PAM debugging" && \
    touch /etc/pam_debug && \
    echo '*.debug /var/log/debug.log' >> /etc/rsyslog.conf && \
    test ! -f /var/log/debug.log && touch /var/log/debug.log && \
    echo "# Instruct FreeRADIUS to use PAM to authenticate users"  >> /etc/freeradius/users && \
    echo "DEFAULT Auth-Type := PAM" >> /etc/freeradius/users && \
    sed -i "s/\s*secret\s*=\s*testing123/secret = $RADIUS_SECRET/" /etc/freeradius/clients.conf && \
#    echo "Add custom freeradius client" && \
#    echo "client client144x {\n  ipaddr = 144.0.0.0/8\n  secret = $RADIUS_SECRET\n}" >> /etc/freeradius/clients.conf && \
    echo "Configuring pam-exec-oauth2 PAM module" && \
    chmod 755 $OAUTH_PAM_PREFIX/pam-exec-oauth2 && \
    chmod 600 $OAUTH_PAM_PREFIX/pam-exec-oauth2.yaml && \
    sed -i 's/@include/#@include/g' /etc/pam.d/radiusd && \
    echo "auth	sufficient	pam_exec.so	debug	expose_authtok	stdout	/opt/pam-exec-oauth2/pam-exec-oauth2 --debug" >> /etc/pam.d/radiusd && \
    echo Add user tester && \
    useradd tester && \
    echo "done."
