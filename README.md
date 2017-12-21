# Using Vapid for Web Push Notifications in a Ruby on Rails Application

This is demo project that accompanies a blog post on using (VAPID for Push notifications in Rails)[]


In this post we will go through how to implement web push functionality in a Ruby on Rails project using VAPID.

## So how does WebPush work?
To get Web Push working you’ll need:
- Your rails server equipped with service workers.
- Your subscriber accessing a browser that has Web Push supported
- A push service provider like Google or Mozilla

## Implementing Web Push

### Setup Vapid Keys
- First step in sending a push message is to set up a pair of one time VAPID keys (public/private) to be saved on your server. These keys will be used to sign the Push API requests. VAPID keys are used as a means of encrypting and sending messages using the web push protocol without needing to send it through a service like Google Cloud Messaging.
- A `manifest.json` file that helps to identify your application 
- You will need to set up a service worker and install on the user’s browser, the service works is subscribed to push events with your public VAPID key.
- Your server will need to make an API request to send a notification to the users subscription
- Your service worker will be set up with a receive ‘push’ event to trigger a notification event on the client side, displaying the notification

The diagram below gives a good outline of how it all works



![Image](https://www.w3.org/TR/push-api/sequence_diagram.png)

### Getting Started

You can use this Git Repository to follow along or setup a new rails app and implment as you read.

There are a few things you will need to set up before you start sending messages.

#### Gems to install:

- WebPush

Go into the project root and install the webpush gem

<script src="https://gist.github.com/lachlanagnew/f5f6c01ee5955c941f46ab3065256a01.js"></script>


This gem is used for the push of the data itself, it deals with all the encryption and requests
	
- Serviceworkers:

<script src="https://gist.github.com/lachlanagnew/cb2ba9513b63f195bb59ce8cb6c8700c.js"></script>

`Serviceworkers-rails` is a gem that allows a rails server to serve out a `service-worker.js` file making it look like it’s from the root directory.

A serviceworker is a bit of javascript that is always running in the background of the brower even if the page isn’t open.They have many useful applications apart from listening for push notifications like offline loading, and periodic background syncs.
To learn more about service workers you can read up here (https://developers.google.com/web/fundamentals/primers/service-workers/)



#### Setting up VAPID keys:

Setting up your VAPID keys gives your server a unique signature to sign the messages send out over the subscription.

Open up your ruby console and do the following:

<script src="https://gist.github.com/lachlanagnew/8008a0cc5ccc3011719019f958b95e83.js"></script>

VAPID is a protocol used for secure data transfer, you can read up more about it in the [spec](https://tools.ietf.org/html/draft-ietf-webpush-vapid-01).
You will want to store these keys in a secure location for future use.

#### Declare manifest.json

The manifest.json is used to pass settings to the browser about the server that is sending push notifications.

<script src="https://gist.github.com/lachlanagnew/a5c2169c41e921414deb9f3160d1171d.js"></script>

And link that in the head tag of you application:
<script src="https://gist.github.com/lachlanagnew/dddc600e2b0eb73ffbc70327714c97f7.js"></script>	


Set up Serviceworker:

Install serviceworker files automatically,

<script src="https://gist.github.com/lachlanagnew/d5311b1ca46d714678d1abbdb304e992.js"></script>
	
Then you declare all the files you wish to be included with the serviceworker

<script src="https://gist.github.com/lachlanagnew/ba462f4f9122033d085e24cf15aa081d.js"></script>

This declares which files will look like they are coming from the root directory, so any file that the service worker references will need to be referenced here

Setting up the ServiceWorker:
	
Set up the service worker to listen to a push:


<script src="https://gist.github.com/lachlanagnew/9386c0151d3ce486cdf008d97f6451a9.js"></script>

Get subscription:

To allow the server to send a push to you, you must first be subscribed to the VAPID public key.

<script src="https://gist.github.com/lachlanagnew/30759d6d1936c80875ab9a8a334816fa.js"></script>

This does a lot so lets break it down;

1. If the browser does not support notifications, then send out an error to stop it from continuing
1. If they have already accepted push notifications, then get the subscription keys 
1. If they haven’t already then get a request to send them push notifications
1. If they accept this, then again get the keys
1. Register the serviceworker
1. Subscribe the serviceworker to the servers public key
1. Send the subscription data to the server

Once the data is sent to the server you should save what you received under your users data table, this will allow you to send a notification out to a particular user.

Send push:

Finally, now you have all of the data necessary, you can send out a message to your client.

<script src="https://gist.github.com/lachlanagnew/4baa96de9df0233e7b298aedb166d0ab.js"></script>

With the details sent in from the subscription, save that to a model and then when you want to send out data send it out using webpush.
We should then see a notification get triggered. 

You can access a [Rails Web Push demo project](https://github.com/seedtech/rails-webpush-demo) via our Github.

The [README](rails-webpush-demo/README.md) has details on how to run this service.

Further reading:
https://web-push-book.gauntface.com/
https://rossta.net/blog/using-the-web-push-api-with-vapid.html
https://tools.ietf.org/html/draft-ietf-webpush-protocol-12








 
