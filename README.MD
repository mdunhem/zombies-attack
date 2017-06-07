```
----------------------------------------------------------------
        CS 355 - Mike Dunhem - Project 1 - Zombies Attack!
  ########  #######  ##     ## ########  #### ########  ######
       ##  ##     ## ###   ### ##     ##  ##  ##       ##    ##
      ##   ##     ## #### #### ##     ##  ##  ##       ##
     ##    ##     ## ## ### ## ########   ##  ######    ######
    ##     ##     ## ##     ## ##     ##  ##  ##             ##
   ##      ##     ## ##     ## ##     ##  ##  ##       ##    ##
  ########  #######  ##     ## ########  #### ########  ######
                  ~ Will you make out alive?! ~
----------------------------------------------------------------
```

## Usage

#### Loading from SML Interpreter Usage
Make sure to run `CM.make "sources.cm";` first, which will load all of the needed files.

Then you can run these commands:
- `Main.run "basic";`
- `Main.run "latent";`
- `Main.run "treatment";`
- `Main.run "help";`

#### Executable Usage
- `./bin/zombies basic`
- `./bin/zombies latent`
- `./bin/zombies treatment`
- `./bin/zombies help`

#### Options
- basic       -     Run basic model
- latent      -     Run latent infection model
- treatment   -     Run with treatment model
- help        -     Print the help message


## How to build

#### How to compile on Unix-like machines
`./build-unix.sh`

#### How to compile on Windows machines
`./build-win.bat`
