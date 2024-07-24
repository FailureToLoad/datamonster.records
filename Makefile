
build:
	docker build -t datamonster-db .

run:
	docker run \
		-e POSTGRES_PASSWORD=${SA_PASS} \
		-e POSTGRES_USER='admin' \
		-e POSTGRES_DB='records' \
		-e APPUSER_PASS=${APP_PASS} \
		-dp 127.0.0.1:8070:5432  \
		--name dm-db datamonster-db 