# jorsel.named

DNS, bind9, named

- [Tutorial](http://www.zytrax.com/books/dns/ch7/queries.html)
- [Tutorial](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-caching-or-forwarding-dns-server-on-ubuntu-14-04)
- [logging](http://www.zytrax.com/books/dns/ch7/logging.html)
- [zones file explained](https://help.dyn.com/how-to-format-a-zone-file/)
- [other ansible example](https://github.com/systemli/ansible-role-bind9/blob/master/templates/bind/zones/db.template.j2)

Check zones:

```bash
for i in $(ls); do echo "Checking zone $i ..."; named-checkzone milkywaygalaxy.be $i; echo ; done
```

Variable objects:
```yml
# DNS setup
dns_zones: 
  - domain: myzone.local
    admin_user: adminuser
    networks:
      - name: network-1
        vlan_tag: 1
        network: 192.168.1.0
        subnetmask: 27
        ttl: 18000
        log_level: "{{ named_default_log_level }}"
        dns_records: []
          - type: A
            value: test-1
            target: 1
          - type: A
            value: test-2
            target: 2
          - type: CNAME
            value: test-3
            target: test-2
        view:
          - recursion: "yes"
            view_records:
              - type: A
                value: gateway
                target: 1
      - name: network-2
        vlan_tag: 22
        network: 192.168.22.0
        subnetmask: 24
        ttl: 18000
        log_level: "{{ named_default_log_level }}"
        dns_records: []
          - type: A
            value: testing
            target: 208
          - type: CNAME
            value: anothertest
            target: testing
        view:
          - recursion: "no"
            view_records:
              - type: A
                value: gateway
                target: 1


```


Example playbook:

```yml
- hosts: dns2
  become: yes
  roles:
    - jorsel.named
```