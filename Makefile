build:
	docker build -t samsheff/geth .

rpc:
	docker run --name geth -d -p 8110:8110 samsheff/geth

kill:
	docker rm -f geth

test:
	curl -XPOST -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x27dc8de9e9a1cb673543bd5fce89e83af09e228f", "latest"],"id":1}' 'localhost:8110'
