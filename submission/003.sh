# How many new outputs were created by block 123,456?
#!/bin/bash
# Armazena as informações de getblockstats na variável block
block=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_271 -rpcpassword=c8rCYuoxHxZW getblockstats 123456)
echo $block | jq .outs # Imprime a quantidade de saídas do bloco 123,456