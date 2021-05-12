build:
	docker build -t quay.io/tartale/tools:bookinfo-reboot-v1 -t quay.io/tartale/tools:bookinfo-reboot-latest .

push: build
	docker push quay.io/tartale/tools:bookinfo-reboot-v1
	docker push quay.io/tartale/tools:bookinfo-reboot-latest
