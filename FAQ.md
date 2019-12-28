General
===============

**Q: What is the relationship of this project to Bitcoin?**

**A:** The code is based on Bitcoin.  The block chain is separate, starting from a different genesis block and therefore creating a separate currency - #611coin or SIL.

**Q: How much does it cost to register a #611coin domain (a.k.a. MyName.611.to)?**

**A:** The cost includes a network fee and a transaction fee.  The fees are denominated in 611s (SIL).  Initially, to register a name object, the fee is 0.1622 SIL. Renew fee (minimum once a year) is 0.0611 SIL.

**Q: How do I obtain #611coin?**

**A:** You have to get them by mining, in the usual Bitcoin way, or by obtaining them from someone else.  For example, you could find someone willing to sell SIL for BTC using a cryptocurrency exchange.
 * https://611project.org/trade/

**Q: Who gets the network fee?**

**A:** The network fee #611coin (regular: 0.0611 SIL) are destroyed by the transaction.  Nobody gets them.

**Q: Who gets the transaction fee?**

**A:** The miners do, just like in Bitcoin.  The standard network fee is 0.0611 SIL. Increasing the value may have an impact on how fast you want your transaction to be processed.

**Q: How long are names good for?**

**A:** You have to execute an update on a name every 120000 blocks (normally about three months), or it expires.  There is no network fee for updates.

**Q: Do I have to pay renewal fees?**

**A:** No, only Bitcoin-like #611coin transaction fees, currently 0.0611 SIL

Usage
===============

**Q: How do I run #611coin?**

**A:** Currently you have to download and compile the software yourself or to use one of the precompiled binaries (packages).  You then run the 611d executable.  Configuration is in ~/.611/611d.conf .

**Q: Can I run #611coin and Bitcoin on the same machine?**

**A:** Yes, this is possible.  The two systems use different port numbers for client to client communication.

**Q: How do I register a name?**

**A:** You must have enough balance to pay the network fee and transaction fee.  Then do:

`611d name_new <name>`

This will output two values - a random number (short) and a transaction ID (longer).

**wait 12 blocks**, then:

`611d name_firstupdate <name> <random> <value>`

**Q: How do I access my #611coin domain using a standard browser or Internet connected device?**

**A:** #611coin name objects are published at ICANN DNS under .611.to. Like `<name>.611.to`
Examples:
 * https://blockexplorer.611.to
 * https://paperwallet.611.to
 * https://wallet.611.to

**Q: I mined #611coin (SIL). Can I register a name now?**

**A:** You have to wait about 100 blocks (normally 2 to 4 hours) for the SIL to mature, in the usual Bitcoin fashion.

**Q: Why is there a separate `name_new` step?**

**A:** This is to prevent others from stealing your new name by registering it quickly themselves when they see your transaction.  The name is not broadcast, only an encrypted version.  There is a mandatory 12 block wait that gives you enough time to broadcast your name with `first_update`, reducing the chance that someone will get in a `first_update` ahead of you.

**Q: How do I list registered names?**

**A:** Use `611d name_list` to see your own names, and `611d name_scan` for the global list.

**Q: How do I transfer a name?**

**A:** You can use: `name_update <name> <value> <toaddress>`

**Q: This is complicated, isn't there a simpler interface?**

**A:** Yes, you can use a precompiled QT-wallet of #611coin containing a user interface menu: "Manage Names"

Design
========

**Q: Why is there a network fee?**

**A:** The network fee is necessary to avoid abuse and payout miners for their effords to secure the #611coin blockchain.

**Q: How are names represented?**

**A:** Names and values are attached to special coins with a value of 0.0611 SIL. Updates are performed by creating a transaction with the name's previous coin as input.

**Q: What if I spend that special #611coin by mistake?**

**A:** The code prevents those coins from being used for normal payments.

Mining
========

**Q: Can I use existing Bitcoin miners?**

**A:** Yes. Moreover #611coin supports merge-mining allowing to mine Bitcoin and #611coin together. Merge-mining can be used to improve overall mining efficency and mining revenue.
