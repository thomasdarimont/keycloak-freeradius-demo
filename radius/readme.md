# Build
```
docker build \
  -t tdlabs/freeradius-server:3.0.18.0 \
  .
```

# Run
```
docker run \
   -t \
   -d \
   --rm \
   --net=host \
   --name my-radius \
   -p 1812-1813:1812-1813/udp \
   tdlabs/freeradius-server:3.0.18.0 \
   -X
 ```


# Testing radius
See: https://www.tldp.org/HOWTO/archived/LDAP-Implementation-HOWTO/radius.html

```
docker exec -it my-radius /bin/bash

root@neumann:/# radtest
Usage: radtest [OPTIONS] user passwd radius-server[:port] nas-port-number secret [ppphint] [nasname]
        -d RADIUS_DIR       Set radius directory
        -t <type>           Set authentication method
                            type can be pap, chap, mschap, or eap-md5
        -P protocol         Select udp (default) or tcp
        -x                  Enable debug output
        -4                  Use IPv4 for the NAS address (default)
        -6                  Use IPv6 for the NAS address

root@neumann:/# radtest tester test localhost:1812 1 testing123
Sent Access-Request Id 131 from 0.0.0.0:46706 to 127.0.0.1:1812 length 76
	User-Name = "tester"
	User-Password = "test"
	NAS-IP-Address = 127.0.0.1
	NAS-Port = 1
	Message-Authenticator = 0x00
	Cleartext-Password = "test"
Received Access-Reject Id 131 from 127.0.0.1:1812 to 127.0.0.1:46706 length 20
(0) -: Expected Access-Accept got Access-Reject
```

# Configure Free-Radius to use PAM
Create a client for Keycloak server(s)...

See: https://networkjutsu.com/freeradius-google-authenticator/

```
less /etc/freeradius/clients.conf 
...
```

Edit the user configuration file /etc/raddb/users, changing DEFAULT Auth-Type = System to DEFAULT Auth-Type = pam for using PAM modules for user authentication.

```
docker run \
   -d \
   --name my-radius \
   -p 1812-1813:1812-1813/udp \
   freeradius/freeradius-server:3.0.18



export PAM_USER=tester

root@neumann:/# echo test | /opt/pam-exec-oauth2/pam-exec-oauth2
Using config file: /opt/pam-exec-oauth2/pam-exec-oauth2.yaml


root@neumann:/# echo test1 | /opt/pam-exec-oauth2/pam-exec-oauth2
Using config file: /opt/pam-exec-oauth2/pam-exec-oauth2.yaml
oauth2: cannot fetch token: 401 Unauthorized
Response: {"error":"invalid_grant","error_description":"Invalid user credentials"}



(0) # Executing group from file /etc/freeradius/sites-enabled/default
(0)   authenticate {
(0) pam: Using pamauth string "radiusd" for pam.conf lookup
(0) pam: ERROR: PAM conversation failed
(0) pam: ERROR: /opt/pam-exec-oauth2/pam-exec-oauth2xxx failed: exit code 2
(0) pam: ERROR: pam_authenticate failed: Authentication failure
```

# Links 
PAM-authentication-not-working
http://freeradius.1045715.n5.nabble.com/PAM-authentication-not-working-td5718096.html
