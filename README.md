# Covid19
Covid19 app built by Swift
There are four main fucntions of the app: 
- fetch statistic informtion related to Covid19
- Map screen for searching
- fetch Covid19 news from Google Feed
- static page

The UI of the app were built by stack views to make sure all the screens is responsive to many different form factors (portrait, landscape, ...)
Error handling when there is no internet and Try again button for fast response when the internet is back

<img src="https://github.com/KateVu/Covid19/blob/master/Images/no_internet.png" width="200">

# Statistic information screens
- Remote API return data in JSON format, using Codable to parse data into native Swift Struct.
- Load data asynchorousely and using catching machanism to reduce network load

Images:

<img src="https://github.com/KateVu/Covid19/blob/master/Images/statistic_portrait.png" width="200"> <img src="https://github.com/KateVu/Covid19/blob/master/Images/statistic_landscape.png" height="200"> <img src="https://github.com/KateVu/Covid19/blob/master/Images/statistic_portrait_detail.png" width="200">

# MAP screens

<img src="https://github.com/KateVu/Covid19/blob/master/Images/map_portrait.png" width="200"> <img src="https://github.com/KateVu/Covid19/blob/master/Images/map_landscape.png" height="200">

# News screens
- Remote API return data from GoogleFeed News, using XMLParser to parse data into native Swift Struct
- Load data asynchorousely

<img src="https://github.com/KateVu/Covid19/blob/master/Images/news_portrait.png" width="200">  <img src="https://github.com/KateVu/Covid19/blob/master/Images/news_detail.png" width="200">

# Static screens

<img src="https://github.com/KateVu/Covid19/blob/master/Images/static.png" width="200">  <img src="https://github.com/KateVu/Covid19/blob/master/Images/static_detail.png" width="200">
