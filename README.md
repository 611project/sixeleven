611
===================

611 is a decentralized key/value registration and transfer system based on Bitcoin technology (a decentralized cryptocurrency).

It's a fork of Namecoin and can be used for multiple purposes, for example a secure and anonymous domain registration service for DNS under SixEleven DOT to: ...611.to

Ownership of a name is based on ownership of a coin, which is in turn based on public key cryptography. The 611 network reaches consensus every few minutes as to which names have been reserved or updated.

In despite of Namecoin SixEleven domain objects will be published and accessible globally via the (611.to) gobal domain name system as long as entries are setup accurate and do not violate the tonic terms of service.

The number of SixEleven coins is restricted to about 611 thousand. Fees and mining values are set appropriate to make sure this service will not become a mass article.

There is a FAQ.md to answer some general questions.

See https://611.to (comming soon) for more information.


Technical
=====================

The Bitcoin protocol is augmented with 611 operations, to reserve, register and update names. In addition to DNS like entries, arbitrary name/value pairs are allowed and multiple namespaces will be available. This will include a personal handle namespace mapping handles to public keys and personal address data.

The protocol differences from bitcoin include:

* Different blockchain, port, IRC bootstrap, dnsseed and message header
* New transaction types: new, first-update, update
* Validation on the new transaction types
* RPC calls for managing names
* Increased network fees to slow down the initial rush and to reward miners.

Please read DESIGN-611d.md for details.


BUILDING
======================

Building is supported on Linux, Windows and Mac (and maybe other *nix compatible systems). For building on Windows or Mac I recommend reading the build instructions in the document folder.

