
# PoC for Authenticating Free-Radius against Keycloak

This setup uses `free-radius`, `keycloak` and the `pam-exec-oauth2` module to authenticate a user through free-radius against Keycloak.

The authentication works like this:
```
free-radius -> PAM -> pam_exec -> pam-exec-oauth2 -> Keycloak
```

# Build

## Build pam-exec-oauth2 module
To rebuild the `pam-exec-oauth2` go binary, just follow the instructions in https://github.com/shimt/pam-exec-oauth2 and copy the resulting native binary `pam-exec-oauth2` into the radius folder.

Note that the `pam-exec-oauth2` module can be configured via `radius/pam-exec-oauth2.yaml`.

## Build custom free-radius image
```
radius/build.sh
```

# Run

## Start Keycloak
This starts a Keycloak instance reachable via `http://localhost:8180/auth` to which you can login with username: `admin` and password: `admin`.

The provided `radiusdemo-realm.json` file is automatically imported into Keycloak
and provides `radiusdemo` realm with a client for radius authentication `svc-radius-client` 
and a user with the username `tester` and password `test` for testing.
```
keycloak/run.sh
```

## Start free-radius
This will start a docker container with the name my-radius listening on ports
`1812-1813:1812-1813/udp`.

Note that you'll need to configure the client networks via the `clients.conf`file.
You can also adjust the default secret `testing123` manually or replace it automatically via the `RADIUS_SECRET` env variable.
```
radius/run.sh
```

# Test Login

The following tests use the `radtest` tool within the `my-radius` container.

## Test Login Fail
This try uses an incorrect password.
```
radius/test-login-fail.sh
```

Output:
```
Sent Access-Request Id 182 from 0.0.0.0:45851 to 127.0.0.1:1812 length 76
	User-Name = "tester"
	User-Password = "wrong"
	NAS-IP-Address = 127.0.0.1
	NAS-Port = 1
	Message-Authenticator = 0x00
	Cleartext-Password = "wrong"
Received Access-Reject Id 182 from 127.0.0.1:1812 to 127.0.0.1:45851 length 20
(0) -: Expected Access-Accept got Access-Reject
```

## Test Login Success
This try uses a correct password.
```
radius/test-login-ok.sh  
```

Output:
```
Sent Access-Request Id 139 from 0.0.0.0:47297 to 127.0.0.1:1812 length 76
	User-Name = "tester"
	User-Password = "test"
	NAS-IP-Address = 127.0.0.1
	NAS-Port = 1
	Message-Authenticator = 0x00
	Cleartext-Password = "test"
Received Access-Accept Id 139 from 127.0.0.1:1812 to 127.0.0.1:47297 length 20
```

# Issues

## Radius users needs to have unix accounts
The current configuration requires that a radius user has an existing unix account.
For the sake of the example we create a `tester` user in the `Dockerfile`.

I'm still looking for the proper `PAM` configuration to not require unix accounts for radius users.