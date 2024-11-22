# Only one single output remains unspent from block 123,321. What address was it sent to?
#!/bin/bash

hash_123=$(bitcoin-cli getblockhash 123321) # Obtendo a hash do bloco 123,321
block_123=$(bitcoin-cli getblock $hash_123) # Obtendo informações sobre o bloco 123,321

# Extraindo o número de transações do bloco
ntx=$(echo "$block_123" | jq -r '.nTx')

# Iterando sobre as transações no bloco 123,321
for ((i=0; i<ntx; i++)); do
    # Extraindo cada transação do bloco
    tx=$(echo "$block_123" | jq -r ".tx[$i]") 
    noutputs=$(bitcoin-cli getrawtransaction "$tx" 1 | jq -r '.vout | length') # Extraindo o número de saídas da transação
    for ((z=0; z<noutputs;z++)) do # Iterando sobre o número de saídas
        utxo=$(bitcoin-cli gettxout "$tx" "$z") # gettxout só retorna se a transação não foi gasta
        if [ ! -z "$utxo" ]; then # Se a variável utxo não for vazia, então:
            
            echo "$utxo" | jq -r .scriptPubKey.address # Exibe o endereço para onde essa transação foi enviada
            break 2

        fi
    done
done
    

