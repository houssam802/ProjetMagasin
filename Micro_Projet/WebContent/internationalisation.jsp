
<html>
   
   <head>
      <title>Locale Specific Currency</title>
   </head>
   
   <body>
      <header>
         <a href="?country=EUR">FRANCE</a>
         <a href="?country=USD">USA</a>
         <a href="?country=MAD">Morrocco</a>
      </header>
         <h1>Locale Specific Currency</h1>

      
      <div align = "center">
         <p>Formatted Currency: ${ currency } </p>
      </div>

      <div id="test"></div>
   </body>
   <script>
        fetch("http://www.floatrates.com/daily/eur.json")
             .then(results => results.json())
             .then(results => {
                        console.log(results.usd.rate);
               });
             //.then(console.log)

   </script>
</html>