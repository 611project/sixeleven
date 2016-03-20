# 611 Design

## Key Operations

Key operations are performed by transactions with version 0x9900 - 0x99ff

* name\_new(hash(rand, name), value)
* name\_firstupdate(name, rand, value)
* name\_update(name, value)

The last is a normal bitcoin-like transaction that does not affect the name.

## Method

A transaction can have a name operation associated with it.  An operation can reserve (name\_new), initialize (name\_firstupdate) or update (name\_update) a name/value pair.

The name\_firstupdate transaction has a network fee.  The network fees represents 611s (SIL) that are destroyed.  This is in addition to the bitcoin-like miner transaction fees.

## Key Operations Detail

* The pubkey script starts with the following constants (OP\_N or OP\_PUSHDATA), followed by a OP_DROP, OP_2DROP or OP_NOP:
  * name\_new: [NAME\_NEW, hash(rand, name), value]
  * name\_firstupdate: [NAME\_FIRSTUPDATE, name, [newtx\_hash,] rand, value]
  * name\_update: [NAME\_UPDATE, name, value]
* name\_firstupdate will be accepted at or after 12 blocks of the matching name\_new
* in case of a collision, the first non-ignore name\_new wins
* new names are valid after name\_firstupdate
* name is a byte array of max length 255
* value is a byte array of max length 1023
* The transaction can only be inserted into a block where the current network fee is less than the network fee output of the transaction
* a name expires 36000 blocks from the last operation

## Network fees

The purpose of the network fees is to slow down the initial gold-rush and to make it profitable for miners to take care on this altcoin.

* Standard network fee is 6.11 cent
       int64 nStart = 611 * CENT / 100;
* It will decrease by factor two every 2^18 or 262144 blocks
       int64 nNetFee = nStart >> (nHeight >> 18);
       nNetFee -= (nNetFee >> 19) * (nHeight % 262144);
* At the very early beginning it was fixed
       if (nHeight <= 10110)
           nNetFee = 611 * CENT / 100;
       if (nHeight <= 2880)
           nNetFee = 611 * CENT / 1000;
       if (fTestNet)
             nNetFee = 1 * CENT;
       return nNetFee;

## Validation

A name operation transaction can be inserted in a block if the following validations pass:

* normal bitcoin validations pass
* if the transaction version does not indicate 611, no inputs can be 611 outputs (i.e. have 611 transaction id and have a 611 script)
* if the transaction version does not indicate 611, terminate with success
* one of the outputs is >= the network fee of the block and has the script: OP\_RETURN (i.e. cannot be used as input, coins are lost)
* if this is an name\_update, exactly one of the inputs is an name\_update or name\_firstupdate on this name and the difference in block numbers is at most 12000.  Also, no other inputs are name operations.
* if this is a name\_firstupdate, exactly one of the inputs is a name\_new with block difference at least 12 but not more than 12000. No other inputs are name operations.
* if this is a name\_new, none of the inputs is a name operation.
* a name\_firstupdate must be on a name never seen or that has expired

## Payment of network fee

One of the outputs of a name\_firstupdate or name\_update transaction is lost (cannot be an input to a further transaction and has a script of exactly "OP_RETURN")

## Applications

The name is normally interpreted as a UTF-8 string composed of several slash-separated substrings.  The first element is a application specifier.

For DNS, the first element shall be "d" and there are exactly two elements.  Mapping into the .611.to domain is simply: d/xyz => xyz.611.to .  The value is interpreted as a zone specification.  It is recommended that names stop serving about 2000 blocks before expiration, as a signal to prevent a forgetful registrant from losing the domain immediately after it expires.

For personal public name, the first element shall be "p" and there are exactly two elements.  The value is interpreted as a json encoded hash.  The "key" element of the cash contains PGP encoded keys.
