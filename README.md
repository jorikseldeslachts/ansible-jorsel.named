# jorsel.named

## Intro

### Ansible
An ansible role to install bind9 or named DNS server on a Linux system. The role is written to be used with a Raspberry Pi but should work on any other Debian distro. RHEL is still work in progress. 

### VLAN support with views
It can be used in combination with VLAN's. The service will make use of so called 'views'. This way it can override certain records based on the VLAN the record was requested on. This can be helpful for example for a gateway that has to point to different addresses depending on the VLAN the requesting machine is in.

### DNS API
It will also install a custom made API written with the Python3 FastAPI package.
The reason for this API is that our current DNS servers are public on Cloudflare. We needed the same domain to be authorative in the local network. Therefor forwarding to Cloudflare would often not work. This API has an endpoint to sync all the public (Cloudflare) DNS records for a specific domain to the local zone files. That way users will not even notice it from inside the local network.


## Links

- [Tutorial](http://www.zytrax.com/books/dns/ch7/queries.html)
- [Tutorial](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-caching-or-forwarding-dns-server-on-ubuntu-14-04)
- [logging](http://www.zytrax.com/books/dns/ch7/logging.html)
- [zones file explained](https://help.dyn.com/how-to-format-a-zone-file/)
- [other ansible example](https://github.com/systemli/ansible-role-bind9/blob/master/templates/bind/zones/db.template.j2)


## Usage

Variables should be defined in [`defaults/main.yml`](./defaults/main.yml). 
This file also contains a yaml object that defines the configuration per domain and per VLAN. It should have the following format:
<br>

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

Example playbook `dns-playbook.yml`:
```yml
- hosts: dns-servers
  become: yes
  roles:
    - jorsel.named
```

Example inventory file `inv.yml`:
```yml
[dns-servers]
192.168.0.3
```

Execute the Ansible run with the following command:
```sh
# normal run
ansible-playbook -u my-sudo-user -i inv.yml --ask-become-pass dns-playbook.yml

# extra verbose run for debugging and troubleshooting
# verbose mode (-vv or -vvv for more, -vvvv to enable connection debugging)
ansible-playbook -u my-sudo-user -i inv.yml --ask-become-pass dns-playbook.yml -v

# dry run
ansible-playbook -u my-sudo-user -i inv.yml --ask-become-pass dns-playbook.yml --check
```

## Known issues:

- On Debian 10 Apparmor blocks filewriting to log and config directory.
  This makes the bind9 service unable to start.
  A solution for this is to add the following to the bottom of ```/etc/apparmor.d/usr.sbin.named``` and then restart the apparmor service with ```systemctl restart apparmor.service``` .

  ```sh
  # Allow bind9/named
  /var/log/bind/** rw,
  /var/log/bind rw,
  /etc/bind/** rw,
  /etc/bind/ rw, 
  ```

## Contributors

Jorik Seldeslachts