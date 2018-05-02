# League of Legends packaged in Flatpak.

This repository contains information to package wine and a runner, which allows us to setup a prefix, install the game and (of course) play it.

**NOTE**: The official Installer doesn't like our environment for some reason, a workaround was to repack it's contents.
[VirusTotal Scan](https://www.virustotal.com/#/file/b8bc735c85a0608fd7c81abc579cfd7a01ea1f1b903a050d8436b3ce2453a562/detection)

It was based on the work of:

>  - GloriousEggroll
>  - johnramsden

Thanks to:

>  - TingPing

## Requeriments

### To run

To run the flatpak you will need to install

> flatpak

You will also need to setup flathub, here, we're doing it in user mode, if you want to run the game in more users than your current one, just remove the `--user` flag.

To setup flathub, you'ill need to run the following in a terminal:

> flatpak --user remote-add --no-gpg-verify --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

After enabling flathub, you will need to install the required runtimes for the game:

> flatpak --user install flathub org.freedesktop.Platform/i386/1.6

> flatpak --user install flathub org.freedesktop.Platform.GL.default/i386/1.6

> flatpak --user install flathub org.freedesktop.Sdk/i386/1.6

### To build

You will need **ALL** of the dependencies necessary to run, **PLUS**:

> flatpak-builder

> ccache

## Building and Installing

Just run:

> flatpak-builder --install --user --ccache --force-clean leagueoflegends com.riotgames.League_of_Legends.json

in your favorite terminal emulator.

Again,  if you want to run the game in more users than your current one, just remove the `--user` flag.

## Running

We're shipping with a `.desktop` file, so after installing, you're pretty much good to go.
But if you want to, you can run it in your favorite terminal editor using the following command:

> flatpak run com.riotgames.League_of_Legends

**NOTE**: Remember to **UNCHECK** the box that says to launch the game.

## TODO
- Make the official installer work
- Strip out unneeded wine libraries

## Contributing

Please follow our contribution guide [here.](./CONTRIBUTING.md)

## Code of Conduct

If you want to contribute to this project, you will need to follow our [Code of Conduct](./CODE-OF-CONDUCT.md)

## License

This project is licensed under the [LGPL-3.0-or-later](./LICENSE.md) License.
