alice=docker exec alice bitcoin-cli -rpcuser=bitcoin -rpcpassword=bitcoin
bob=docker exec bob bitcoin-cli -rpcuser=bitcoin -rpcpassword=bitcoin
charlie=docker exec charlie bitcoin-cli -rpcuser=bitcoin -rpcpassword=bitcoin


up:
	@docker-compose up -d
	@echo ""
	@echo Generating 200 blocks versus Alice to reach coinbase maturity...
	@sleep 2
	@${alice} generatetoaddress 200 `${alice} getnewaddress` >/dev/null
	@echo ""
	@echo "Tip: Use the following alias for interact with a node"
	@echo 'alias bcli="${alice}"'

down:
	@docker-compose down

info:
	@echo "Alice (patched)"
	@${alice} getmempoolinfo
	@${alice} getrawmempool
	@echo ""
	@echo "Bob (patched)"
	@${bob} getmempoolinfo
	@${bob} getrawmempool
	@echo ""
	@echo "Charlie (unpatched)" 
	@${charlie} getmempoolinfo
	@${charlie} getrawmempool

send:
	@chmod a+x ./scripts/send-message
	@bash ./scripts/send-message bcrt1qez7p3xytd45l2h8dmta4g0s2t4z8y78qguhdlx
	@echo ""
	@echo "Tip: Use the following command to get the transaction's ids entered in mempool"
	@echo "bcli getrawmempool"
