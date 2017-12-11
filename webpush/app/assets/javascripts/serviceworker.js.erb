self.addEventListener("push", function(event) {
  var title = (event.data && event.data.text().split("-")[0]) || "Message from Commercial view";
  var body; body = event.data.text().split("-")[1];
  var tag = "push-simple-demo-notification-tag";
  var icon = 'logo.png';

  event.waitUntil(
      self.registration.showNotification(title, {
          body: body,
          icon: icon,
          tag: tag
      })
  );
});

self.addEventListener('notificationclick', function(event) {
    event.notification.close()
    var url = "/"
    event.waitUntil( clients.matchAll({type: 'window'}).then( function(windowClients) {
            for (var i = 0; i < windowClients.length; i++) {
                var client = windowClients[i];
                if (client.url === url && 'focus' in client) { return client.focus()}
            }
            if (clients.openWindow) { return clients.openWindow(url) }
        })
    );
});
