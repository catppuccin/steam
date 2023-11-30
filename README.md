

<h3 align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
	Catppuccin for <a href="https://store.steampowered.com/">Steam</a>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
    <a href="https://github.com/catppuccin/steam/stargazers"><img src="https://img.shields.io/github/stars/catppuccin/steam?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
    <a href="https://github.com/catppuccin/steam/issues"><img src="https://img.shields.io/github/issues/catppuccin/steam?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
    <a href="https://github.com/catppuccin/steam/contributors"><img src="https://img.shields.io/github/contributors/catppuccin/steam?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

<!-- <p align="center">
	<img src="https://raw.githubusercontent.com/Dukeatron/steam/main/assets/ss.png"/>
</p>

## Previews

<details>
<summary>🌻 Latte</summary>
<img src="https://raw.githubusercontent.com/catppuccin/steam/main/assets/latte.png"/>
</details>
<details>
<summary>🪴 Frappé</summary>
<img src="https://raw.githubusercontent.com/catppuccin/steam/main/assets/frappe.png"/>
</details>
<details>
<summary>🌺 Macchiato</summary>
<img src="https://raw.githubusercontent.com/catppuccin/steam/main/assets/macchiato.png"/>
</details>
<details>
<summary>🌿 Mocha</summary>
<img src="https://raw.githubusercontent.com/catppuccin/steam/main/assets/mocha.png"/>
</details> -->

## Usage

<!-- ### Automated installation (linux only):
Just run this command in your favorite terminal emulator!
```bash
bash <(curl -s https://raw.githubusercontent.com/catppuccin/steam/main/install.sh)
```

Or, if you use the fish shell, do this:
```fish
bash ( curl -s https://raw.githubusercontent.com/catppuccin/steam/main/install.sh | psub )
``` -->
### Contributing/Manual installation:
-- make sure you have nodejs and yarn installed
1.  Clone this repo locally and run yarn install in the project directory then run the `accent` script to generate the flavours and accents.
2.  Download and install [SFP](https://github.com/PhantomGamers/SFP) (this is used for theming the new steam client)
3.  Find the flavour - accent combo you'd like to try in the generated dist folder and copy it to `~/.steam/steam/steamui/skins/Catppuccin-[flavour-accent]` (linux) or `c:\Program Files\Steam\steamui\skins\Catppuccin-[flavour-accent] (windows)`. If the skins folder doesn't exist, create it.
4.  Open SFP and navigate to the settings, then select the theme. After the correct theme is selected navigate to the home menu and click `Start Steam` then `Start Injection`(if Inject on Steam start is not enabled)

5. Make changes to the css in _friends/libraryroot.scss if you'd like to contribute.


<!-- ### NOTE: [steam-library](https://github.com/AikoMidori/steam-library), which the library styling is based on, has strange steps for windows-- until there is a separate implementation that accounts for this, windows users will only be able to style the header, and some of the panels.
### NOTE 2: Latte is extremely painful to theme for, so at the moment it isn't nearly as complete as the dark themes. -->

## TODO

- [x] accent and flavour generation
- [ ] Steam library fully themed
- [ ] Steam small mode fully themed
- [ ] Steam friends list/chat fully themed
- [ ] Steam big picture support (pulling from [ctp/steam-deck](https://github.com/Catppuccin/steam-deck))
- [ ] Steam web pages fully themed - will be done on [ctp/userstyles/steam](https://github.com/Catppuccin/userstyles)
- [ ] Rewrite install script to work with new ui rewrite (linux and windows support) ((maybe automate [SFP](https://github.com/PhantomGamers/SFP) installation?))
- [ ] Optional JS plugin for changing accent (maybe flavour) on the fly
	
## 💝 Thanks to

- [Dukeatron2000](https://github.com/Dukeatron) original steam ui theme
- [Kylie 🍪](https://github.com/covkie)

&nbsp;

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
	Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
</p>

<p align="center">
	<a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a>
</p>
