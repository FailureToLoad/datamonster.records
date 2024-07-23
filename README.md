# datamonster.records

This repo uses a Makefile to build the image and run the container.  

`make build` will build the image.  
`make run` will run the container.

The run command also maps the container to `loalhost:8070`.  

The init-db.sh script sets up all the tables and users.  

## Related Projects
 
 [datamonster.api](https://github.com/FailureToLoad/datamonster.records) - The api that datamonster.web communicates against
 [datamonster.web](https://github.com/FailureToLoad/datamonster.web) - A NextJS site which utilizes datamonster.api for critical logic and data persistence 
