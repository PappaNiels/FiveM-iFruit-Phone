--[[
    Thanks for downloading my script!
    If you want to edit the contacts names, see contacts.lua. It is at the top of the code. 
]]

-- This is the key hash to pull up your phone
keyOpenPhone = 27 -- Arrow up. See the docs (https://docs.fivem.net/docs/game-references/controls/) for all the controll hashes to find the best one for you.

-- This is the text shown for the parts of the phone that do not exist yet. This will be prompted to the user.
notAvailable = "This part of the phone does not exist (yet) ..."

-- Enable this to add the standard GTA people to your contacts (Lester, Long John Teabag and some strippers).
useStandardContacts = true 
-- Enable this to add every active player to your contacts.
addEveryPlayerToContacts = true 

-- This will be the name of the contact if you add the bomb via the setBombContact event.
bombContact = "Detonate Bomb"

-- This will be the avatar of the 'Assistent' Female for a female and the other way around.
assistant = "char_pa_female" -- char_pa_male

-- These are the 'headers' above the phone. You can translate them to your own language if that is desired. 
headers = {
    "Email",
    "Texts",
    "Contacts",
    "Play Quick Job",
    "Job List",
    "Settings",
    "Snapmatic",
    "Internet",
    "SecuroServ"
}