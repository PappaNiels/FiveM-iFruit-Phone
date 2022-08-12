# FiveM-iFruit-Phone

This is the only phone you need in FiveM! The original iFruit phone from Grand Theft Auto Online. With almost all the capabilities from the original phone (Still missing: internet, quick job, camera, securoserv and the call option). And the most amazing part, it is 3% thinner, 3% faster and comes with a 30 hour queue.

# How to use

Resource wise it is like every other resource. Put it into your resource folder and add the resource in your server config. This resource has no dependencies, so you can use it in any server (if the controls and event are not already used ;) ).

The controls are like the phone from GTA:O. Arrow keys, enter and escape are controls that are used but can be changed if desired (Native: `IsControlJustPressed()`, Key hashes: https://https://docs.fivem.net/docs/game-references/controls/. 
The main settings can be changed in the config.lua. For example, if you don't want the standard GTA:O contacts.

## Send a e-mail

To send an email you need to trigger the following event:

```lua
TriggerClientEvent("cl:ifruit:receiveEmail", player, sender, title, message, withFile) -- or TriggerEvent if you are triggering it client-sided (remove the player parameter)
``` 

- player = The server id that receives the email (interger)
- sender = The server id that sent the email (interger)
- title = The title of the mail (string)
- message = The message the mail contains (string)
- withFile = If the email has a picture attached to it (boolean) (no images can be attached yet)

## Send a text 

To send a text you need to trigger the following event:

```lua
TriggerClientEvent("cl:ifruit:receiveText", player, sender, title, message, hour, minute, avatar) -- or TriggerEvent if you are triggering it client-sided (remove the player parameter)
```

- player = The server id that receives the text (interger)
- sender = The server id that sent the text (interger)
- title = The title of the text (string)
- message = The message the text contains (string)
- hour = The hour that the text was sent (interger). You can use GetClockHours() to get the current hour.
- minute = The minute that the text was sent (interger). You can use GetClockMinutes() to get the current minutes.
- avatar = The avatar of the certain person (string). Default is char_default, but you can use others, like those from the contacts (see contacts.lua).

## Add the 'Detonate Bomb' contact

This part will add or remove the 'Detonate Bomb'contact. This only adds or removes the contact for now. 

```lua
TriggerClientEvent("cl:ifruit:setBombContact", player, addContact) -- or TriggerEvent if you are triggering it client-sided (remove the player parameter)
```

- player = The server id that gets or loses the 'Detonate Bomb' contact (interger)
- addContact = If the contact gets added or removed (boolean)

## Invite to job 

To add an job invite you need to trigger the following event: 

```lua
TriggerClientEvent("cl:ifruit:invitePlayer", player, sender, title, description, colour, avatar, returnEvent, isServerEvent) -- or TriggerEvent if you are triggering it client-sided (remove the player parameter)
```

- player = The server id that receives the job invite (interger)
- sender = The server id that sent the job invite (interger)
- title = The title of the job (string)
- description = The description of the job (string). The heists all start with 'Heist : ' and all the others start with 'Invite to ', but is not mandatory.
- colour = The colour of the field (interger). See research.md for all the known colours.
- avatar = The avatar of the certain person (string). Default is char_default, but you can use others, like those from the contacts (see contacts.lua).
- returnEvent = The event that triggers when you accept the job invite (string)
- isServerEvent = If the event is a server event (boolean)

# Contributing

If you want to add a feature that is missing, add a non-existing feature or optimize the code, feel free to make a pull request. And if there is something that does not work as intended you can make an issue or make a pull request to fix it. Every kind of help will be much appreciated <3.
