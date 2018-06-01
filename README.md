# League of Legends packaged in Flatpak.

This repository contains information to package wine and a runner, which allows us to setup a prefix, install the game and (of course) play it.

It was based on the work of:

>  - GloriousEggroll
>  - johnramsden

Thanks to:

>  - TingPing
>  - julianrichen

## Requeriments

### To run

To run the flatpak you will need to install

> flatpak

You will also need to setup the winepak Platform and SDK, please refer to [It's repository.](https://github.com/h4ndshake/winepak-sdk-images)

### To build

You will need **ALL** of the dependencies necessary to run, **PLUS**:

> flatpak-builder

## Building and Installing

Just run:

> flatpak-builder --arch=i386 --install --user --force-clean leagueoflegends com.riotgames.League_of_Legends.json

in your favorite terminal emulator.

## Running

We're shipping with a `.desktop` file, so after installing, you're pretty much good to go.
But if you want to, you can run it in your favorite terminal editor using the following command:

> flatpak run com.riotgames.League_of_Legends

**NOTE**: Remember to **UNCHECK** the box that says to launch the game.

## TODO
- ~~Make the official installer work~~
- ~~Strip out unneeded wine libraries~~

## Contributing

Please follow our contribution guide [here.](./CONTRIBUTING.md)

## Code of Conduct

If you want to contribute to this project, you will need to follow our [Code of Conduct](./CODE-OF-CONDUCT.md)

## License

This project is licensed under the [LGPL-3.0-or-later](./LICENSE.md) License.

Riot Games, League of Legends and PvP.net are trademarks, services marks, or registered trademarks of Riot Games, Inc.
