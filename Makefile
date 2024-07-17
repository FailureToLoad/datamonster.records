
build:
	docker build -t datamonster-db .

run:
	docker run -dp 127.0.0.1:8070:5432 --name dm-db datamonster-db