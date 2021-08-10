# ansible-role-docker-cleanup

Ansible role to cleanup unused docker resources every night.


## Usage

`requirements.yml`:

```yaml
---
- src: aklinkert.docker_cleanup
```

`playbook.yml`:

```yaml
- name: setup docker cleanup
  hosts: docker
  roles:
    - role: aklinkert.docker_cleanup
```

# Licence

  Apache v2.0
