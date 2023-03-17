#!/bin/bash
formatledger='%(date);;%(join(note));%(payee);;%(quantity(amount*-1));%(account);\n'
sedvar='/Opening/d; s/Expenses://g' 
ledger csv -r Megaf --format $formatledger | sed -e "${sedvar}" > ledgMeg.csv
sedvar=$sedvar'; /:Megaf/d'
ledger csv -r Rifa --format $formatledger | sed -e "${sedvar}" > ledgRif.csv
sedvar=$sedvar'; /:Rifa/d'
ledger csv -r Mir --format $formatledger | sed -e "${sedvar}" > ledgMir.csv
sedvar=$sedvar'; /:Mir/d'
ledger csv -r CashFond --format $formatledger | sed -e "${sedvar}" > ledgCashF.csv
sedvar=$sedvar'; /:CsshFond/d'
ledger csv -r TransportC --format $formatledger | sed -e "${sedvar}" > ledgTrans.csv
sedvar=$sedvar'; /:TransportC/d'
ledger csv -r Cash$ --format $formatledger | sed -e "${sedvar}" > ledgCash.csv
ledger csv -r Lelya --format $formatledger | sed -e "${sedvar}" > ledgLel.csv
