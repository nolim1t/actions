# My Authored Github Actions

Here are some github actions that I've authored. Hope you find them useful.

If you have any issues, feel free to report them [here](https://github.com/nolim1t/actions/issues/new)

## Action List

You can see that the actions are working properly, by checking out [the following link](https://github.com/nolim1t/actions/actions?query=workflow%3A%22Check+that+nlcnx%2Ai5y4.onion+is+online+every+half+day+using+the+torssh+action%22), which makes use of both SSH and SCP actions over TOR.

### TOR Utilities

As I have a few hidden services, I need a way of deploying to them from a git repo. Thanks to github actions this is possible.

* [***torscp***](https://github.com/nolim1t/actions/tree/master/torscp) - Action Name: ***nolim1t/actions/torscp@0.2.0***  (takes 3 variables: PRIVATE_KEY, SRC, DEST)
* [**torssh**](https://github.com/nolim1t/actions/tree/master/torssh) - SSH command over tor! Action name ***nolim1t/actions/torssh@0.2.0***. Takes PRIVATE_KEY, USERHOST, and CMD variables.



