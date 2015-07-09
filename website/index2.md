main-page container!!!

``` css
.masthead {
  position: relative;
  text-align: center;
  padding: 0em;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 0px;
  border-bottom: none;
  background-position: 50% 50%;
  background-image: url(lib/assets/masthead.jpg);
}
.ui.segment.masthead {
  margin: 0em;
  padding: 12rem 0em;
}
.titlehead {
  text-shadow: 0 2px 4px rgba(0,0,0,0.4);
}
.ui.search .main-search {
  -moz-border-radius: 0px;
  -webkit-border-radius: 0px;
  border-radius: 0px;
  width: 800px;
}
.masthead .divider {
  visibility: hidden;
}
.featured-properties .divider, .featured-neighborhoods .divider {
  visibility: hidden;
}
.ui.menu .item {
  position: static;
}
.main-page {
  -moz-box-shadow: 0 0 5px 5px #888;
  -webkit-box-shadow: 0 0 5px 5px#888;
  box-shadow: 0 0 5px 5px #888;
}
```
__sidebar|left vertical labeled|inverted left-sidebar|header1,item1,item2;header2,item3,item4__

>basic inverted attached segment!!!
> __menu|header|basic inverted attached|image, lib/assets/logo.png;256;35||LIST YOUR SPACE__
> __menu|header|basic inverted attached main-menu|text, Your Partner in Home Search|HOME,ABOUT,NEIGHBORHOOD GUIDES|Sign In, Sign Up__
>

<!-- -->

>basic masthead segment!!!
> # Your Partner in Home Search;;titlehead inverted center
> ___Explore our database of properties within the Metro. Customize your search and discover the right space that is best for you!;titlehead inverted center___
> ___
>>center aligned grid!!!
>>>search-segment segment!!! __search|fluid category|main-search|Search for Properties...||__
>>>

<!--  -->

>basic attached featured-properties segment!!!
>### Featured Properties;;titlehead center
> ___
>>container grid!!!
>>>five doubling link cards!!!
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>>basic segment!!!
>>>>___

<!--  -->

>basic attached secondary featured-neighborhoods segment!!!
>### Neighborhoods;;titlehead center
> ___
>>container grid!!!
>>>five doubling link cards!!!
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>__card|type|http://lorempixel.com/320/240,Header,Description|meta1,meta2|icon,user,Text1;text,Text2__
>>>>basic segment!!!
>>>>___

<!--  -->

``` js
$('.ui.dropdown').dropdown();
```