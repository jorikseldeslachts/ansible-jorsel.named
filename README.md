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

Example playbook:

```yml
- hosts: dns2
  become: yes
  roles:
    - jorsel.named
```