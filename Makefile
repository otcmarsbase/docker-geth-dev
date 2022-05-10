build:
	docker build -t samsheff/geth .

rpc:
	docker run --name geth -d -p 8110:8110 samsheff/geth

kill:
	docker rm -f geth

test:
	curl -XPOST -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x60c56553495612d4b93b6BC1deffE937223eaF51", "latest"],"id":1}' 'localhost:8110'

import-key:
	geth account import --password /root/miner.pw /root/miner.key
	cp ~/.ethereum/keystore ./keystore