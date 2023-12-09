# datamonster.records

Run the docker-compose to stand up the postgres DB container. I know its not really needed but raw docker commands are a pain.
Afterwards, run the following command to get the container's IP address.
`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dm_db`

Set up an environment variable for the connection string in the form of  
EXPORT CONN_STRING="postgres://appuser:Password1@IPADDRESSHERE:5432/records"

Those creds aren't sticking around forever, its just convenient to have them here for the time being.
