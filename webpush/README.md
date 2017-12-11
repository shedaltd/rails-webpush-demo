WebPush via VAPID with Ruby on Rails

As most modern websites begin to move to dynamic web applications, it is getting to the point where the difference between native applications and web applications is next to none.
So when it came around in July of  2016 and chrome implemented a web push feature using Firebase Cloud Messaging (FCM) it allowed for web developers to have the same level of interaction with their users as mobile developers did through push notifications.

In this post we will go through how to implement webpush functionality in a Ruby on Rails project using VAPID.

So how does WebPush work?
The WebPush flow requires three
Your rails server
Your user
A push service e.g. Google or Mozilla

Overview

First step in sending a push message is to set up a pair of one time VAPID keys to save in your server that will be used to sign the Push API requests. VAPID keys are used as a means of encrypting and sending messages of a webpush protocol without needing to send it through the google cloud.
A manifest.json file linked to your page that identifies your application settings
You will need to set up a service worker that is subscribed to the servers public VAPID key
Your server will need to make an API request to send a notification to the users subscription
Your service worker will be set up with a receive ‘push’ event to trigger a notification event on the client side, displaying the notification


https://www.w3.org/TR/push-api/sequence_diagram.png
Getting Started

There are a few things you will need to set up before you start sending messages.

Gems to install:
Webpush:
<script src="https://gist.github.com/lachlanagnew/f5f6c01ee5955c941f46ab3065256a01.js"></script>

This gem is used for the push of the data itself, it deals with all the encryption and requests

Serviceworkers:
<script src="https://gist.github.com/lachlanagnew/cb2ba9513b63f195bb59ce8cb6c8700c.js"></script>

Serviceworkers-rails is a gem that allows a rails server to send out a service-worker.js file making it look like it’s from the root directory
A serviceworker is a bit of javascript that is always running in the background of the brower even if the page isn’t open. It has many useful applications apart from listening for push notifications like offline loading, and periodic background syncs.
To learn more about service workers you can read up here (https://developers.google.com/web/fundamentals/primers/service-workers/)



Setting up VAPID keys:
Setting up your VAPID keys gives your server a unique signature to sign the messages send out over the subscription.

Open up your ruby console and do the following:

<script src="https://gist.github.com/lachlanagnew/8008a0cc5ccc3011719019f958b95e83.js"></script>

VAPID is a protocol used for secure data transfer, you can read up more about it in the spec (https://tools.ietf.org/html/draft-ietf-webpush-vapid-01)
You will want to store these keys in a secure location for future use.

Declare manifest.json
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

If the browser does not support notifications, then send out an error to stop it from continuing
If they have already accepted push notifications, then get the subscription keys
If they haven’t already then get a request to send them push notifications
If they accept this, then again get the keys
Register the serviceworker
Subscribe the serviceworker to the servers public key
Send the subscription data to the server

Once the data is sent to the server you should then save that under your users data to be able to send a notification out to a particular user.

Send push:

Finally, now you have all of the data necessary, you can send out a message to your client.

<script src="https://gist.github.com/lachlanagnew/4baa96de9df0233e7b298aedb166d0ab.js"></script>

With the details sent in from the subscription, save that to a model and then when you want to send out data send it out using webpush.
We should then see a notification get triggered. This is still a very new technology so it will most likely change rapidly.

Further reading:
https://web-push-book.gauntface.com/
https://rossta.net/blog/using-the-web-push-api-with-vapid.html
https://tools.ietf.org/html/draft-ietf-webpush-protocol-12








