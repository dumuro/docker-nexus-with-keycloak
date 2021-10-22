# docker-nexus-with-keycloak
Nexus3 support keycloak authentication

### Keycloak configuration
```json
{
  "realm": "example",
  "auth-server-url": "https://example.org/auth/",
  "ssl-required": "external",
  "resource": "example",
  "verify-token-audience": true,
  "credentials": {
    "secret": "KEY"
  },
  "use-resource-role-mappings": true,
  "confidential-port": 0,
  "policy-enforcer": {}
}
```

### Docker build
```shell
docker login
docker build -t example/nexus3 .
docker tag example/nexus3 example/nexus3:VERSION
docker push example/nexus3
```