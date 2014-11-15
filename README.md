ximber
======

A tool for naming outlets in xibs.

##Backstory

I have a problem with interface builder and it looks like this:

![Image Alt](https://raw.github.com/paulsamuels/ximber/master/READMEAssets/poor_naming.png)

All of those views have the same name. Being a kind developer I'll manually update these labels so they reflect what views they represent - this will save others and my self pain later down the line. This seems like redundant work when most of these views are connected to nicely named properties in my classes... this sounds like something I can automate.

```
../path/to/ximber path/to/xibs/*.{xib,storyboard}
```

![Image Alt](https://raw.github.com/paulsamuels/ximber/master/READMEAssets/nice_naming.png)

##Warning

You are using version control right?? If not you really shouldn't be using any tools that modify your source and you should probably be looking at your workflow as you are not practicing safe coding.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request