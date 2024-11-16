# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
#!/bin/bash
# Obtendo informações sobre o esse bloco
raw_tx=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 1 )
script=$(echo "$raw_tx" | jq -r '.vin[0].txinwitness[2]') # Extraindo o terceiro elemento de txinwitness o qual é o redeem script
script_decoded=$(bitcoin-cli decodescript $script) # decodifica o redeem script
# Extrai a chave pública do scriptPubkey que assinou a primeira entrada
public_key=$(echo $script_decoded | jq -r '.asm | split(" ") | map(select(test("^(02)[0-9a-f]{64}$")))[0]')
echo $public_key # Imprime a chave pública