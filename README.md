# devenv
This is a linux machine that I can use for setting up a dev environment quickly. Hopefully it's pretty reusable, but there might need to be company specific ansible playbooks as time goes on.

Assumes you've installed something for running Docker, e.g. Docker desktop for macs.

Also assumes you've install vagrant. I highly recommend installing vagrant's vagrant-scp plugin for simplifying getting files on and off your vm.

## Usage

first time:
```vagrant up```

to login:
```vagrant ssh```

To pause:
```vagrant halt```

To resume:
```vagrant resume```

To re-initialize
```vagrant reload```

