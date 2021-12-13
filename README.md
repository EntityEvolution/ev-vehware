# ev-vehware
A simple NUI vehicle warehouse

# License
This project does not contain a license, therefore you are not allowed to add one and claim it as yours. You are not allowed to sell this nor re-distribute it, if an issue arises, we will proceed to file a DMCA takedown request. You are not allowed to change/add a license unless given permission by Mauricio Rivera (Bombay). If you want to modify or make an agreement, you can contact Mauricio Rivera (Bombay). Pull requests are accepted as long as they do not contain breaking changes. You can read more about unlicensed repositories [here](https://opensource.stackexchange.com/questions/1720/what-can-i-assume-if-a-publicly-published-project-has-no-license) if questions remain.

## Features
* Standalone
* Using polyzones to allow multiple places to open UI and to delete vehicles.
* Easy to configure using a JSON file along with config in the lua part.
* Wowie, no price?

## Dependencies
* [PolyZone ](https://github.com/mkafrin/PolyZone)

## Documentation
- Recomendation: Do not create the truck in the same location even if it's different types.
- Creating more Zones: Go to `Config.DeleteZones` copy the block of circle zone and paste under the last one. Then just update the coords and name. Then update the `Config.DropZones`.
- Creating more vehicles: Go to the `config.json`, copy a block and place it at the bottom (don't forget the comma from the one above). Update the id to the next number and update all the info you want.
- Framework Money: Go to line 97 and trigger a custom event with `currentPayout` as an argument. Make sure to do some checks for hackers.
- Framework Alert: Go to line 22 and trigger a server event which only police receives. You can add as a parameter a message or just handle the message server side.

### [Forum Post](https://forum.cfx.re/t/release-standalone-ev-vehware/4752999)
### [Discord](https://discord.com/invite/u4zk4tVTkG)
### [Donations](https://www.buymeacoffee.com/bombayV)
### [Preview](https://c.file.glass/4jg01.png)
### [Video](https://youtu.be/3NAW9tgptGc)
