build:
	docker build -t samsheff/geth .

rpc:
	docker run --name geth -d -p 8110:8110 samsheff/geth
	sleep 2
	rm -rf tmp
	docker cp geth:/tmp/ ./tmp
	echo ./tmp/go-eth*/* | xargs cat | jq .address

kill:
	docker rm -f geth

balance:
	curl -XPOST -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBalance","params":["$(of)", "latest"],"id":1}' 'localhost:8110'

send-eth:
	curl -XPOST -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{"from":"$(from)","to":"$(to)","value":"$(value)"}],"id":1}' 'localhost:8110'
