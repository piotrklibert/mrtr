# MTR - Multi-user (rich)Text Realms

## Why do this, whatever it is?

I always wanted to. I didn't have the time to properly research and a lot of my
knowledge may be very outdated, to the point that I'm not even sure if my idea
is original. But that doesn't matter, I just want to build this. This very
thing was one of the major reasons I learned programming, so I thought I should,
now that I have a chance of doing so.

## What MRTR is (supposed to be)

### TL;DR: ###

    Multiplayer Interactive Fiction environment based on (improved) LPMuds'
    ideas of interactive, in-world development.

    With images, sounds and animations. Peer-to-peer distributed. And much more.

I expect cookies and ponies to also be there.

### Long story ###

MUDs are ancestors and predecesors to "modern" MMORPG games. There are many
different types of MUDs (there are also many types of MMO* games); they are all
text-based, but the nature and content of the text you see differ drastically
from MUD to MUD.

As a programmer and hobbyist writer, as well as a gamer, I was more interested
in the backend - how you create content for the MUD - since first time I tried
playing them. I had enough luck to quickly settle for an LPMud.

LPMuds are a unique in their feature-set type of MUDs (or at least they were
unique before).

    Some technicalities: LPMuds are written as runtime environments and virtual
    machines for (a little exotic) programming language called LPC. The language
    itself, as its name suggests, follows C syntactically, but is much higher level
    (because of memory safety if for no other reason), provides sane higher-level
    data-structures (objects/hashes, sequences), uses prototype-based OOP, supports
    static and dynamic typing and in general is an interesting language. However,
    the runtime environment is even more interesting: where other languages start a
    REPL, LPC starts a MUD, which functions as a REPL if you connect to it.

    In an LPC environment everything not implemented as part of a driver
    (interpreter/VM + parts of RE) is implemented in files, which themselves are
    objects inside RE. What this means is that you can edit and reload the code for
    anything and have your changes immediately visible. From a REPL (i.e. MUD
    connection) you can manipulate all aspects of the system. Here comes the
    interesting part: and so can everyone else whom you give access to your server!

LPMuds give you a way to *create* content - text, media and scripts tying them
together - collaboratively, together with others, in real-time. On the other
hand, both in creating and actually playing, in terms of content presentation
MUDs remain constrained to whatever TELNET can handle, which is not much, nor
is it convenient.

On the other hand we have systems such as Inform 7 - environments and languages
for creating and playing Interactive Fiction works. They are single-player
(although there seems to be one muti-player project, but it looks dead), but are
not limited to text alone: the scripts can create all manners of interactive
objects and employ multimedia efortlessly.

MRTR tries to merge both feature-sets, with a couple additional goals.

## What will it look like? ##

For frontend I plan to provide a client which works like DrRacket repl or GUI
IPython, that is capable of displaying both styled text and images. That's for
the start.

The backend will be containerized for security and it won't "look" at all (only
on the command line).

The content will be created in some language(s) I still need to choose.

# TODO

[] 3
[] 3
[] 3
[] 3
[] 3
[] 3
[] 3
[] 3
