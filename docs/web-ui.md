# Accessing the UI

### Default UI

You can access the default UI or any custom UI with the following url from you local host. Just make sure that the exposed port is 8080.

```
http://<local-ip>:8080/gui
```

### NG UI

The setup provides some additional UIs which if enabled can be accessed using the below url from local host. For enabling this UI you need to pass `UTORRENT_WEB_UI=ng` while running the container.

```
http://<local-ip>:8080/gui
```

This is considering the port exposed is `8080` which is the default.

