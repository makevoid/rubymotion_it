# Reading a file form resources directory
5 May 2012

Reading a file from "resources" directory is that easy:

    path = NSBundle.mainBundle.pathForResource "file", ofType: "type"
  
if you want to read a file named "posts.json":

    path = NSBundle.mainBundle.pathForResource "posts", ofType: "json"
  
easy as that!

---
# Hello Button in MobileRuby
4 May 2012

<script src="https://gist.github.com/2596291.js"> </script>

<https://gist.github.com/2596291>

---
# Adding an external framework to MobileRuby
4 May 2012

open Rakefile

    app.frameworks = app.frameworks + ["FrameworkName"]

for example if you want to add **MapKit**:

    app.frameworks = app.frameworks + ["MapKit"]

so you can use framework classes inside your project!

enjoy!


---
# Console and code reloading
4 May 2012

in the console: 

    (main)>> load "./app/map_view"
    => #<RuntimeError: #load is not supported in RubyMotion>
    (main)>> require "./app/map_view"
    => #<RuntimeError: #require is not supported in RubyMotion>

some functions are not supported, code reloading looks a bit hard at first but...


---
# RubyMotion resources
4 May 2012

- [getting started](http://www.rubymotion.com/developer-center/guides/getting-started/)
- [motion-cocoapods](https://github.com/HipByte/motion-cocoapods)
- [motion-cocoapods rdoc](http://rubydoc.info/gems/motion-cocoapods/1.0/frames)

