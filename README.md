Ruby ImageMagic Converter  (v0.8)
===================================

Task Manager to work with images on the basis of the ImageMagick library. It has the ability to do the following:
 * resize
 * crop
 * filtering(black and white, sepia, etc.)
 * css sprites
 * rotate


Principle of work
=================
Program is run from the console and performs the tasks described in config.yaml


Installation
============
Open a terminal window and run this command:

    $ gem install bundler

Install all of the required gems from your specified sources:

    $ bundle install


Usage
=====		
Navigate to the folder with the project and run the program.

    $ ./rimc.rb


Customization
=============
All settings are stored in the config.yaml (* tagged with the required parameters)

    descriptions:
     resize:
      - "small image":                            #(*) The name of the method can be any
         src: "path/to/folder/or/file"            #(*) relative to the folder with the file rimc.rb
         dest: "path/to/folder/or/file"           #(*) relative to the folder with the file rimc.rb
         size: "ipod"                             #(*) New size.("ipod"is alias defined in alias.yaml)
                                                  #    Also can be defined as "320x480"
         aspect_ratio: true                       # Resized such that the aspect ratio should be retained
         prefix: "s_i-"                           # Prefix in the name(s) of new file(s)
         format:                                  #
          - jpg                                   # Formats that are processed

      # You can define other methods of 'resize' here

     crop:
      - "thumbnail":                              #(*) The name of the method can be any
         src: "path/to/folder/or/file"            #(*) relative to the folder with the file rimc.rb
         dest: "path/to/folder/or/file"           #(*) relative to the folder with the file rimc.rb
         from: "center"                           #(*)
         area: "320x480"                          #(*) Area.
                                                  #    Also can be defined as alias (see alias.yaml)
         prefix: "thumb-"                         #
         format:                                  #
          - jpg                                   # Formats that are processed

      # You can define other methods of 'crop' here

     css_sprite:                                  
      - "horizontal":                             #(*) The name of the method can be any
         src: "path/to/folder/with/images"        #(*) relative to the folder with the file rimc.rb
                                                  # output location for generated image:  &lt;input folder&gt;.png
                                                  # output location for generated stylesheet: &lt;input folder&gt;.&lt;style&gt;
         
         layout: "horizontal"                     # specify layout algorithm (horizontal, vertical or packed)
         style: "css"                             # specify stylesheet syntax (css, scss or sass)
         selector: "div."                         # specify custom css selector (see below)
         cssurl: "www.lodossteam.com"             # specify custom css url (see below)
         nocomments: true                         # suppress generation of comments in output stylesheet

      # You can define other methods of 'css_sprite' here 

     filtering:
      - "black/white":                            #(*) The name of the method can be any
         src: "path/to/folder/or/file"            #(*) relative to the folder with the file rimc.rb
         dest: "path/to/folder/or/file"           #(*) relative to the folder with the file rimc.rb
         filters:                                 #(*) 
          - bw                                    # black/white(bw) or sepia(sepia)
         prefix: "bw-"                            #
         format:                                  #
          - jpg                                   # Formats that are processed

      # You can define other methods of filtering here

     rotate:
      - "rotate":                                 #(*) The name of the method can be any
         src: "path/to/folder/or/file"            #(*) relative to the folder with the file rimc.rb
         dest: "path/to/folder/or/file"           #(*) relative to the folder with the file rimc.rb
         angle: 90                                # default 0
         prefix: "rotate-"                        #
      
      # You can define other methods of rotation here 
      
    tasks:
     default:                                     # execution order
      - small image                               #
      - big image                                 #
      - thumbnail                                 #
      - rotate                                    #
      - black/white                               #
      - sepia                                     #
      - horizontal                                #
      - vertical                                  #
      - packed                                    #


Selector
========

By default, the CSS generated is fairly simple. It assumes you will be using `<img>`
elements for your sprites, and that the basename of each individual file is suitable for
use as a CSS classname. For example, the following files:

    images/icons/high.png
    images/icons/medium.png
    images/icons/low.png

... when run with:

     css_sprite:
      - "horizontal":
         src: "images/icons"
         
... will generate the following css:

    img.high   { width: 16px; height: 16px; background: url(images/icons.png)   0px 0px no-repeat; }
    img.medium { width: 16px; height: 16px; background: url(images/icons.png) -16px 0px no-repeat; }
    img.low    { width: 16px; height: 16px; background: url(images/icons.png) -32px 0px no-repeat; }

If you want to use different selectors for your rules, you can provide the `selector` option. For
example:

    css_sprite:
      - "horizontal":
         src: "images/iconsl"
         selector: "span.icon_"
         
... will generate:

    span.icon_high   { width: 16px; height: 16px; background: url(images/icons.png)   0px 0px no-repeat; }
    span.icon_medium { width: 16px; height: 16px; background: url(images/icons.png) -16px 0px no-repeat; }
    span.icon_low    { width: 16px; height: 16px; background: url(images/icons.png) -32px 0px no-repeat; }

Customizing the CSS Selector Per Image
======================================

If you want to specify a custom selector for each individual image, then name the image files
accordingly - the library will map '\_\_' (double underscore) to a single space ' ' in any source
image filename. For example:

    images/icons/div.foo__span.icon_alert.png
    images/icons/div.bar__span.icon_alert.png

... when run with:

    css_sprite:
     - "horizontal":
        src: "images/icons"
        selector: "div.example"

... will generate:

    div.example div.foo span.icon_alert { ... first file   ... }
    div.example div.bar span.icon_alert { ... second file  ... }
    

If you want to specify a psuedo class such as `:hover` for some of your images, the library will also
map '--' (double dash) to a colon ':' in any source image filename. For example:

    images/icons/alert.png
    images/icons/alert--hover.png

... when run with:

    css_sprite:
     - "horizontal":
        src: "images/icons"
        selector: "span.icon_"

... will generate:

    span.icon_alert       { ... first file  ... }
    span.icon_alert:hover { ... second file ... }
    
CSS Url
=======

By default, the RIMC generates simple url's that contain the basename of the
unified sprite image, e.g:

    css_sprite:
     - "horizontal":
        src: "images/icons"

    # generates: url(icons.png)

...but you can control the generation of these url's using the `:cssurl` option:

For most CDN's, you can prepend a simple string to the image name:

    css_sprite:
     - "horizontal":
        src: "images/icons"
        cssurl: "http://s3.amazonaws.com/"

    # generates:  url(http://s3.amazonaws.com/icons.png)


