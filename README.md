# Classroom Bot

A bot made for easier management of online classes.
[Invite the bot to your server](https://discordapp.com/api/oauth2/authorize?client_id=691945666896855072&permissions=297888850&scope=bot).
To see a list of commands, use ?help.

## Features

### Draw of hands
Users can raise their hand to answer/ask questions to the teacher using a text command. That way, everyone doesn't speak over eachother in voice chat. The teacher can pick the next student in the queue, pick a random one or pick a specific student. A list of students with their hand up can also be seen.

### Questions
Students can ask questions using a text command. The teacher can then go through them one at a time.

### Mute
Tired of students talking when they shouldn't? Force mute a channel, so only the teacher can speak!

### Your idea here
Got any other ideas? Send me a tweet [@TweetMeepsi](https://twitter.com/TweetMeepsi). Check the [trello](https://trello.com/b/owJzJaVt/classroom-bot) development board to see if i am already working on it first though!

## Building and running
You dont need to run the bot yourself, i am already doing it (see the invite link above). But if you want to run it yourself, here's how to do it. Note: this can only be built on linux. If you want to run it on windows, see the "Running with docker" section.

### Requirements
* CMake
* Make
* A C++ compiler
* libssl-dev
* zlib1g

### Installing aegis.cpp
This bot uses the Aegis library to interface with the Discord API. To install it, follow these steps:
1. Clone [my fork of aegis.cpp](https://github.com/GitMeep/aegis.cpp), the normal one won't work, as it doesn't support voice states yet.
2. Run `install-deps.sh` (may need sudo)
3. In the aegis repository, run these commands to build it:
```sh
$ mkdir build
$ cd build
$ cmake .. -DCMAKE_CXX_STANDARD=17 -DBUILD_SHARED_LIBS=OFF
```
4. Then, to install the library, run: `make install` (may need sudo)

### Setting up classroom bot

1. Start by cloning the repository.
2. Go to your [discord developer applications page](https://discordapp.com/developers/applications) and press "New Application". Give it some name and press the "Copy" button under "client id".
3. In the side bar in your application page, click on "Bot", and press "Add Bot". Give the bot a name, and change the icon if you want.
4. Click the invite link above, but don't add the bot to the server. Instead, replace the numbers after "client_id=" in the URL with your own client id, and press enter. Then you can add your own bot to your server.
5. On the bot page, press the "Copy" button under "token". This token should be kept a secret.
6. In src/main.cpp, replace TOKEN with your token.
7. Then, in the root folder of the repository, run these commands:
```sh
$ mkdir build
$ cd build
$ cmake ..
$ make -j 8
```
8. You can now run the bot by typing `./questionsbot [token]` in the build directory, replacing `[token]` with your bot token. I recommend saving it as an environment variable and passing that in using `${VARIABLE_NAME_HERE}`, for example `./questionsbot ${BOT_TOKEN}`.

## Running with docker
I have created an image on Docker Hub to run the bot easily on linux, mac and windows. If you don't have docker, start by [downlaoding it](https://www.docker.com/). When you have it up and running, the container can be started using this command, which downloads the image and runs it:
```sh
docker run --publish 443:443 --env BOT_TOKEN=YOUR_TOKEN_HERE --detach --name cb meepdocker/classroom-bot:latest
```
This command may need sudo if you are on linux. The bot can be stopped using:
```sh
docker rm --force cb
```
Again, it can be a good idea to set up the token as an environment variable.

## Config
On first run, a default config file will be generated. This is where you set the bot token, database info and probably more in the future.
Variables with a value following the pattern `${VAR_NAME}` are treated as enironment variables and will be evaluated when the config is loaded. Should an environment variable be undefined, it will evaluate to an empty string.
If `useUrl` is true, the program will use a url to connect to the server. Otherwise, it uses `user`, `password` and `host` options.

## Developing
If you want to help with development, awesome, here's the basic structure of the project. Please fork the repo and submit a pull request if you want to make changes.

### The main class
The main class is ClassroomBot which lives in main.cpp and main.h. It keeps track of the commands using a map and recieves messages sent in the discord channels on the function onMessage. From here it parses the command and finds the relevant command class to pass it onto. It also handles the help command.

### Commands
Commands are each represented by a class inheriting from the Command class. These live in src/bot/commands. A command can be registered to the bot via the registerCommand function (see main.cpp for examples). The command constructor takes in the ClassroomBot object, which should be passed to the parent constructor, which extracts the aegis::core and saves it in a member variable. When a command is registered, getCommandInfo is called, which returns a struct containing info about the command (name, aliases, description, etc). When a command is invoked by a user, it is first checked that the bot has the necessary permissions by calling checkPermissions on the command object. The call function is then called with the command's parameters and a CurrentCommand struct (from command.h) containing relavant id's for the issued command. These parameters have to be passed to Command::call, the parent class, which saves the structure in a member variable for easier use.

### Trello
[Trello](https://trello.com/b/owJzJaVt/classroom-bot) is used to keep track of tasks. Mostly just so i can remember what i need to do. If you become a regular contributer, i'll add you to it too, and give you access to the main repo.
