---
title: Notes on Linux Distributions
date: 2021-04-21
---
I've been using Linux for the past 3 years or so, and I've used a
couple distributions. These are just some surface-level observations
in the differences between the distributions I've used. I likely don't
know what I'm talking about.

I currently run Archlinux on my desktop computers, and Alpine on the
server this website is hosted on.

# Archlinux
* Widely used as a desktop distro by "Linux enthusiasts".
* AUR contains the second-biggest software repository out of all Linux
distributions.
* Usually has the latest versions of software
* No partial upgrades. The way its package system is designed, you
can't selectively upgrade packages, you must upgrade the whole system
at once.
* Anything can be uploaded to the AUR by anyone. If you read the
PKGBUILDS to check for malware before installing, this is a non-issue.

# NixOS
* Nix's repository is the largest software repository of all Linux
distributions, and usually has the latest versions of software.
* Source-based, while still having a binary cache, so you only need to
compile things that haven't been compiled on Nix's official build
server.
* Stateless OS configuration, system can be recreated with the nix
config files. You can have your entire system: packages, daemons,
configuration ("dot") files, all managed by Nix and stored in a single
git repository.
* Slower package management compared to other distributions. Nix does
more than just installing packages, it also configures them and starts
up any daemons you've configured. Naturally, because it does more, it
takes longer.

# openSUSE
* Has both rolling-release and a periodically released versions.
* Has YaST, which attempts to be an all-in-one program for configuring
the system.
* Weird video codec situation. Out-of-the-box, you will be unable to
watch videos on YouTube, Twitter, et. al. You'll have to install a
video codec pack from a third party repository. This has never been
fun to do for me.
# Alpine
* Uses musl libc and busybox.
* Package manager is fast and simple to use. Being able to pin
repositories is nice.
* Uses OpenRC, a simpler init than systemd.
* Very resource-efficient, which is one of the reasons its use in Docker
images is prevalent.
* Repositories (specifically the edge repositories) are up-to-date and
well-maintained.

