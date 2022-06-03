# Code Monkey Apple

This is a project I use in all of my personal iOS apps. It contains many small features and extensions. 

Everything is MIT licensed. Feel free to copy any individual features.

I do not recommend taking a dependency on this package. It has an audience of one (me).

## Localization

### Manual

Resources:

- [Apple: Maintaining Your Own String Files](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/MaintaingYourOwnStringsFiles/MaintaingYourOwnStringsFiles.html)

#### Generate Strings File

For the development language:

```sh
find Sources/CodeMonkeyApple/. -name \*.swift -print0 | xargs -0 genstrings -o Sources/CodeMonkeyApple/Resources/en.lproj
```

For other supported languages:

```sh
find Sources/CodeMonkeyApple/. -name \*.swift -print0 | xargs -0 genstrings -o Sources/CodeMonkeyApple/Resources/de.lproj
```
