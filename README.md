# ansible-role-docker-cleanup

[![test](https://github.com/aklinkert/ansible-role-docker-cleanup/actions/workflows/test.yml/badge.svg)](https://github.com/aklinkert/ansible-role-docker-cleanup/actions/workflows/test.yml)

Ansible role that installs a systemd timer which runs `docker system prune -af` every night, removing unused containers, networks, images and build cache.

## Requirements

- ansible-core 2.16 or newer
- A systemd based Debian or Ubuntu host with Docker installed
- Privilege escalation (`become: true`), the role writes to `/usr/local/bin` and `/etc/systemd/system`

## Role variables

| Variable | Default | Description |
| --- | --- | --- |
| `docker_cleanup_schedule` | `*-*-* 01:00:00` | systemd `OnCalendar` expression for the cleanup run |

## Usage

`requirements.yml`:

```yaml
---
- src: aklinkert.docker_cleanup
```

`playbook.yml`:

```yaml
- name: Set up docker cleanup
  hosts: docker
  become: true
  roles:
    - role: aklinkert.docker_cleanup
      vars:
        docker_cleanup_schedule: "*-*-* 03:30:00"
```

## License

Apache v2.0
