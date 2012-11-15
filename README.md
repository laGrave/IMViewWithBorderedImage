# IMViewWithBorderedImage
===

IMViewWithBorderedImage is a subclass of UIView which can present an image and border around it. 
  
&nbsp;
## Why not subclassing UIImageView
===
First of all I want to get the ability for setting some space between border and image. It means that image should not necessarily lays edge to edge. So I've made it with `drawInRect:` method but not just setting `imageView.image` property.

## How it looks like
===

##### Standart representation of view. No borders, no offset and content mode is "scale to fill"

![image](http://f.cl.ly/items/1Z0D041c3b002R2v1T3n/Копия%20Photo%205.jpg)
&nbsp;

##### After setting border width and color

![image](http://f.cl.ly/items/0q3c0H030n0E0n0K0i32/Копия%20Photo%201.jpg)

##### Change border width, color and set content mode to "aspect fit"
![image](http://f.cl.ly/items/2T11141J1k3i0K2y4704/Копия%20Photo%203.jpg)

##### Get rounded corners and set big image offset
![image](http://f.cl.ly/items/3s001G3t33260z0T2J2K/Копия%20Photo%204.jpg)




## Installation
===
	  
* Drag IMViewWithBorderedImage.h\.m files into your project.
* Add the **QuartzCore** framework to you project

*If you plan to use my classes in a lot of places inside your app, I recommend importing it directly inside your prefix file.*

&nbsp;
## Usage
===
(see example XCode project demo)

You just create with `alloc\initWithFrame:` like any another UIView and start to setup it's properties:

```objective-c
@property (nonatomic, strong) UIImage *image;       //Image which will be added to center of view
@property (nonatomic) NSUInteger borderWidth;       //Border width. Default is 0;
@property (nonatomic, strong) UIColor *borderColor; //Border color. Default color is black
@property (nonatomic) NSUInteger offsetWidth;       //Offset width. Offset looks like another border, which always sticks around image

@property (nonatomic, strong) UIColor *offsetColor; //Offset color. Default color is white and it's the same as background color of a view

@property (nonatomic) NSUInteger cornerRadius; //corner raduis

/ * Represents the way image positioning on a view.
 The default value is IMViewWithBorderedImageContentModeScaleToFill */
@property (nonatomic) enum IMViewWithBorderedImageContentMode contentMode; 
```

License
-------
MIT Licence

Copyright (c) 2012 Igor Mischenko ([russian blog](http://lagrave.weebly.com)). All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.