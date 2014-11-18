ximber
======

A tool for naming outlets in xibs.

##Backstory

I have a problem with interface builder and it looks like this:

![Image Alt](https://raw.github.com/paulsamuels/ximber/master/READMEAssets/bad_constraints_naming.png)

You spend ages setting up the constraints just the way you want them. However when you come back a day, week, month... later it's pretty much impossible to work with the constraints made in interface builder. It's often much easier to just delete all the things and start again. After getting really fed up of this process I decided to create a quick tool to give the constraints better names, which changes the above image into this:

![Image Alt](https://raw.github.com/paulsamuels/ximber/master/READMEAssets/good_constraints_naming.png)

This is roughly based on the visual formatting language that we all know and love and then some minor amends to make the labels smaller.

---

On a similar note it makes sense to do the exact same thing with outlet connection names where possible. You start of with something like this:

![Image Alt](https://raw.github.com/paulsamuels/ximber/master/READMEAssets/poor_naming.png)

then after running `ximber` you end up with:

![Image Alt](https://raw.github.com/paulsamuels/ximber/master/READMEAssets/nice_naming.png)

In this case the tool has added a userLabel that utilises the names of the IBOutlet's in your source code.

##Installation

There are no fancy installation steps currently. Just build this project and put the build product `ximber` wherever you want to use it.

##Usage

```
path/to/ximber ./**/*.xib
```

Just call `ximber` and throw in a glob that captures all your xib/storyboard files

##Warning

You are using version control right?? If not you really shouldn't be using any tools that modify your source and you should probably be looking at your workflow as you are not practicing safe coding.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request