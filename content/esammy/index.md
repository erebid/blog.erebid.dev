+++
title = "E-Sammy"
+++
A Discord bot for making memes from images/gifs/videos.

[Mailing list](mailto:~samhza/public-inbox@lists.sr.ht)

[GitHub page](https://github.com/samhza/esammy)

It draws inspiration from [esmBot](https://projectlounge.pw/esmBot/) but aims to be lighter and easier to selfhost.

It can be run on any operating system/architecture supported by Go and FFmpeg.

![screenshot](img/screenshot.png)

---

## Dependencies

- [Go](https://golang.org/doc/install) (only required to build)
- [FFmpeg](https://ffmpeg.org/) (required for gifs/videos)

## Obtaining
### From source
If you have Go installed (recommended):
```
go get samhza.com/esammy/cmd/esammy
```
### Using prebuilt binaries
- [Windows (x64)](https://samhza.com/pub/esammy/windows/esammy.exe)
- [Linux (x64)](https://samhza.com/pub/esammy/linux/esammy)
- [macOS (x64)](https://samhza.com/pub/esammy/darwin/esammy)
- [Linux (ARMv7 for Raspberry Pi 2/3/4)](https://samhza.com/pub/esammy/armv7/esammy)

## Running
Create a file called `esammy.config` in the folder where you want to run the bot, or the folder where you downloaded the binary. Set the config options, here is an [example config](https://git.sr.ht/~samhza/esammy/blob/master/esammy.config.example).

Run either `esammy` or `./esammy` depending on how you installed E-Sammy. For Windows, double-click `esammy.exe` and if you get a popup select "run anyway".

## Commands
| **Command**                         | **Description**                            |
|-------------------------------------|--------------------------------------------|
| meme \<top text> [,bottom text]     | impact font meme                           |
| motivate \<top text> [,bottom text] | motivational poster meme                   |
| caption <text>                      | ifunny caption meme                        |
| speed [speed default = 2]           | sets the speed of the video/gif to [speed] |
