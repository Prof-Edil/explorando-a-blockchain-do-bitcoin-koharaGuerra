# Which tx in block 257,343 spends the coinbase output of block 256,128?
#!/bin/bash

# Obtendo a hash do bloco 256,128
hash_256=$(bitcoin-cli getblockhash 256128)
block_256=$(bitcoin-cli getblock $hash_256) # Obtendo as informações do bloco 256,128

# Extraindo a transação coinbase (primeira transação) do bloco 256,128
coinbase_out=$(echo "$block_256" | jq -r '.tx[0]')

# Obtendo a hash do bloco 257,343
hash_257=$(bitcoin-cli getblockhash 257343)
block_257=$(bitcoin-cli getblock $hash_257) # Obtendo as informações do bloco 257,343

# Extraindo o número de transações do bloco
ntx=$(echo "$block_257" | jq -r '.nTx')


# Iterando sobre as transações no bloco 257,343
for ((i=0; i<ntx; i++)); do

    # Extraindo cada transação do bloco 257,343
    tx=$(echo "$block_257" | jq -r ".tx[$i]")

    # Obtendo informações sobre a transação
    raw_tx=$(bitcoin-cli getrawtransaction $tx 1)

    # Verificando se a transação gastou a coinbase
    spent=$( echo "$raw_tx" | jq -r '.vin[] | select(.txid == "'$coinbase_out'")')


    # Se a transação gastar a coinbase output do bloco 2, exiba
    if [ ! -z "$spent" ]; then # Se a variável spent não for vazia, então:
        echo "$tx" # Exibe a transação que gastou a coinbase
        break

    fi
done