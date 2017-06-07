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

The program can be run from either inside of the SML REPL or compiling it into
an executable. If running from the SML REPL, make sure to run `CM.make "sources.cm";`
first, which will load all of the needed files. Otherwise run the build script
based on the operating system you are using. Instructions on how to run all
of these are listed below.

#### Loading from SML REPL Usage

First run `CM.make "sources.cm";`, then you can run any of these commands:
- `Main.run "basic";`
- `Main.run "latent";`
- `Main.run "treatment";`
- `Main.run "help";`

#### Executable Usage

First run the appropriate build script, then you can run any of these commands:
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
