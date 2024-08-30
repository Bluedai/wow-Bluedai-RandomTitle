# Deutsch

### Kurzbeschreibung:
Ändere deinen Charaktertitel zufällig mit verschiedenen Auslöseroptionen!

### Beschreibung:
Mit Zufallstitel kannst du deinen WoW Charaktertitel bei jedem Login oder per Klick ändern! Wähle aus, welche Titel ausgeschlossen werden sollen, und nutze die Einstellungsmöglichkeiten, um den Titelwechsel zu personalisieren: Bei jedem Login erscheint ein Popup mit einem Button zum Wechseln, ein anklickbares Symbol an der Minimap oder ein Chat-Befehl für Makros. Perfekt für Spieler, die eine dynamische Darstellung ihres Charakters wünschen!

# English

### Short Description:
Change your character's title randomly with various trigger options!

### Description:
RandomTitle allows you to change your WoW character's title at every login or on-demand! Exclude titles you don't want and customize when the title changes: a popup with a button at each login, a clickable icon near the minimap, or a chat command for macros. Perfect for players who want a dynamic display of their character's titles!


### Version History

**0.4.2 - 30.08.2024**
- **Feature Additions:**
  - New Title Popup: After your character's title is randomly changed, the new title will now be displayed as a text popup. This popup appears in the center of the screen with a large and fades out after a few seconds. It provides immediate feedback on which title has been selected for your character.
  - Title Display Option: The popup that shows the newly selected title can be managed in the addon's settings. If preferred, you can disable this feature.

**0.4.1 - 14.08.2024**
- compatibility with WoW 11.0.2

**0.4.0 - 24.07.2024**
- compatibility with WoW 11.0.0

- **API Changes:**
  - config.lua: The method InterfaceOptions_AddCategory was replaced with Settings.RegisterCanvasLayoutCategory because it no longer works after patch 11.0.
  - minimap.lua: Updated to reflect changes in the configuration method. The call to InterfaceOptionsFrame_OpenToCategory was replaced with Settings.OpenToCategory.

- **Code Optimizations:**
  - Introduced Bluedai_RT_Variables to store global variables, starting with the new category variable.

**0.3.2 - 09.05.2024**

#### Improvements and Changes:
- compatibility with WoW 10.2.7

**0.3.1 - 23.03.2024**

#### Improvements and Changes:
- compatibility with WoW 10.2.6

**0.3.0 - 20.01.2024**

#### Improvements and Changes:
- **Feature Additions:**
  - Added: New slash command /brt to set a random title.
  - Added: Users can now directly access the options menu by right-clicking on the Minimap icon.

- **User Experience:**
  - Added a tooltip to the Minimap icon, displaying the addon's name for easy identification.
  - Adjusted the options menu frame size for a seamless integration of the scrollbar at the right edge, providing additional space for longer titles.

- **Code Optimizations:**
  - Changing the comments in minimap.lua from German to English.

**0.2.1 - 17.1.2024**

#### Improvements and Changes:
- compatibility with WoW 10.2.5

**0.2.0 - 31.12.2023**

#### Improvements and Changes:
- **Bug Fixes:**
  - Fixed an issue where the addon only worked after reloading.

- **File Updates:**
  - Updated the 'toc' file, which improved tooltips in the addon selection.

- **Feature Additions:**
  - Options now display the number of titles you have.

- **Code Optimizations:**
  - Refined the code for consistent language use; it's mostly in English now.

- **User Experience:**
  - Removed debug chat outputs.
  - Reworked the Minimap icon: it has a new symbol and is now movable.
