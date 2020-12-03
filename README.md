# packer-project-yandex-jenkins_swarm_agent

#### Описание
Проект с packer шаблоном для создания образа Swarm агентов Jenkins в Yandex Cloud на основе ранее существующего базового образа.

- `install_packer.sh` - скрипт установки Packer
- `jenkins-agent-image.json` - packer шаблон
- `playbook.yml` - Ansible Provisioner Playbook
- `roles` - каталог ролей для Ansible Provisioner Playbook
- `roles/requirements.yml `- файл установки роли

#### Переменные
| Variable | Default | Comment |
| -------- | ------- | ------- |
| `source_image_folder_id` | id каталога `main` | id каталога Yandex Cloud исходного образа |
| `source_image_family` | `centos-8-jenkins-agent` | Семейство исходного образа |
| `zone` | `ru-central1-a` | Зона в которой будет ВМ |
| `folder_id` | id каталога `main` | id каталога образа |
| `subnet_id` | id каталога `main` | id подсети VPC Yandex |
| `instance_name`| `centos-8-jenkins-agent` | Имя ВМ  |
| `instance_cores` | 2 | Количество vCPU |
| `instance_mem_gb` | 4 | Количество ГБ RAM |
| `disk_size_gb` | 10 | Количество ГБ HDD диска |
