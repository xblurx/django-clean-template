django/gunicorn/nginx clean template

#### Initial setup:

`cd django-clean-template/systemd`

- set up {user} and {group} in gunicorn.service
- setup databases and add your app in `src/config/settings.py`

- to run:
```
./install.sh
```

В конфиге Django заполните настройки базы данных (`src/config/settings.py`).

Посмотреть статус gunicorn демона:

```bash
sudo systemctl status gunicorn
```

Логи gunicorn'а лежат в `gunicorn/access.log` и `gunicorn/error.log`.

После изменения systemd конфига надо перечитать его и затем перезапустить юнит:

```bash
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
```
