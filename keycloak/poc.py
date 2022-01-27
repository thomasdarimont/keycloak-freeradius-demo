from tokenize import group
from keycloak import KeycloakAdmin
keycloak_superadmin = KeycloakAdmin(server_url="http://localhost:8080/auth/",
                               username='admin',
                               password='admin',
                               realm_name="master",
                               verify=True)




payload = {"realm": "diego2", "enabled": True,
 "users": 
    [
       {
           "id": "diego",
           "email": "diego@diego.com",
           "enabled": True,
           "firstName": "Diego",
           "lastName": "Araujo",
           "username": "diego",
           "credentials": [
               {
                   "temporary": False,
                   "type": "password",
                   "value": "diego"
               },
            ],
            "attributes" : 
                [
                    {"customerNumber": "140661"},
                    {"customerNumber": "140662"}
                ]
           
       }
   ]}



keycloak_superadmin.create_realm(payload=payload, skip_exists=True)
keycloak_realm= KeycloakAdmin(server_url="http://localhost:8080/auth/",
                               username='admin',
                               password='admin',
                               realm_name="diego2",
                               user_realm_name="master",
                               verify=True)

users = keycloak_realm.get_users({})
print(users)

group_payload = {
                "name": "estudantes"
            }
keycloak_superadmin.create_group(payload=group_payload)

#11934898715
(11) 93489-8715