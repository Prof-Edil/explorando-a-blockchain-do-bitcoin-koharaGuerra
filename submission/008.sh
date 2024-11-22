# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
#!/bin/bash
# Obtendo informações sobre o esse bloco
raw_tx=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 1 )

script=$(echo "$raw_tx" | jq -r '.vin[0].txinwitness[2]') # Extraindo o terceiro elemento de txinwitness o qual é o redeem script

verify=$(echo "$raw_tx" | jq -r '.vin[0].txinwitness[1]') # Extraindo o segundo elemento de txinwitness que indica a pubkey utilizada

script_decoded=$(bitcoin-cli decodescript $script) # Decodifica o script
# Chaves públicas indicadas no script
public_key1=$(echo $script_decoded | jq -r '.asm | split(" ") | map(select(test("^(02|03)[0-9a-f]{64}$")))[0]')
public_key2=$(echo $script_decoded | jq -r '.asm | split(" ") | map(select(test("^(02|03)[0-9a-f]{64}$")))[1]')

if [ "$verify" == "01" ]; then #se verify for 01,
        echo $public_key1 #A pubkey1 assinou a input 0

else
        echo $public_key2
fi