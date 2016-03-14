> %html .no-js lang=""
> > %head
> > %meta charset="utf-8"
> > %title "title"
> > %meta name="description" content=""
> > %meta name="viewport" content="width=device-width, initial-scale=1"
> > %link rel="apple-touch-icon" href="app-touch-icon.png"
> > %link rel="stylesheet" href="css/normalize.css"
> > %link rel="stylesheet" href="css/main.css"
> > %script src="js/vendor/modernizr-2.8.3.min.js"
>
> > %body
> > <!-- [if lt IE 8]>
> > %p .browserupgrade "You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience."
> > <![endif]-->
> > %p "Hello world! This is HTML5 Boilerplate."
> > %script src="https://code.jquery.com/jquery-{{JQUERY_VERSION}}.min.js"
> > %script src="js/plugins.js"
> > %script src="js/main.js"
> > > %script!
> > > window.ga=function(){ga.q.push(arguments)};ga.q=[];ga.l=+new Date;
> > > ga('create','UA-XXXXX-Y','auto');ga('send','pageview')
> >
> > %script @async @defer src="https://www.google-analytics.com/analytics.js"
