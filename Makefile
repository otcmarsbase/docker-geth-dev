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

test:
	curl -XPOST -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x60c56553495612d4b93b6BC1deffE937223eaF51", "latest"],"id":1}' 'localhost:8110'

import-key:
	mkdir -p /tmp/docker-geth-dev
	cp ./miner.* /tmp/docker-geth-dev/
	docker run --rm -v /tmp/docker-geth-dev:/root ethereum/client-go account import --password /root/miner.pw /root/miner.key
	cp -r /tmp/docker-geth-dev/.ethereum/keystore ./keystore
	rm -rf /tmp/docker-geth-dev