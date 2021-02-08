# growlab/unbound

Unbound + Alpine Linux

### Como usar este repositório

Para compilar, `make build`
Dev environment no `docker-compose.yml`. Usar porta **5335**. Edite o mapeamento na configuração `./config/pi-hole.conf`:

```
server:
    logfile: "/var/log/unbound/unbound.log"
    verbosity: 3

    interface: 0.0.0.0
    # port: 5335
    port: 53
```

No Swarm, `docker stack deploy -c unbound-macvlan.yml unbound`

---

## TODO

- IPv6 MACvLan - swarm yaml
- Integrar o unbound ao pihole: rodar na mesma overlay e habilitar service descovery `dig +short tasks.unbound`

---
