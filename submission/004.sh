# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`
# Comando deriveaddress é usado para retornar um endereço de um descritor.
# tr indica que o endereço a ser derivado é taproot e q4q7qurj é usado para o checksum

address=$(bitcoin-cli deriveaddresses "tr(xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2/*)#q4q7qurj" [100,100])
echo $address | jq -r '.[0]' #-r serve para tirar as aspas e .'[0]' para pegar o primeiro endereço