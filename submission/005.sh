# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
#!/bin/bash

# Obtendo informações sobre a transação
raw_tx=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 1)

#Extraindo e listando as chaves públicas das entradas da transação
public_keys=$(echo "$raw_tx" | jq -r '.vin[] | if .txinwitness != null then .txinwitness[1] elif .scriptSig.asm != "" then .scriptSig.asm else null end')

# Formatando como um array JSON adequado para createmultisig
public_keys=$(echo "$public_keys" | jq -R -s -c 'split("\n") | map(select(. != ""))')

# Cria um endereço multisig 1-of-4 P2SH
multisigaddress=$(bitcoin-cli createmultisig 1 $public_keys)

# Imprime somente o endereço
echo $multisigaddress | jq -r .address