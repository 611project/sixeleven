611 [coin]
===================

611 [coin] is a decentralized key/value registration and transfer system based on *Bitcoin* technology (a decentralized cryptocurrency).

As a fork of *Namecoin*, 611 offers a unique blockchain secured and anonymous domain registration service. Blockchain information can be published and accessed by any Internet device using the Domain Name Service (DNS) of *611.TO*.

Ownership of a name is based on ownership of a coin, which is in turn based on public key cryptography. The 611 network reaches consensus every few minutes as to which names have been reserved or updated.

In despite of *Namecoin* 611 blockchain domain objects will be published and accessible globally using the (611.to) gobal Domain Name System as long as entries are setup accurate and do not violate the *tonic* terms of service.

The number of 611 coins is restricted to about 611-thousand. Fees and mining values are set appropriate to ensure a stable value of asset.

There is a FAQ.md to answer some general questions.

Check https://www.611project.org for more information.


Technical
=====================

The *Bitcoin* protocol is augmented with 611 operations, to reserve, register and update names. In addition to DNS like entries, arbitrary name/value pairs are allowed and multiple namespaces will be available. This will include a personal handle namespace mapping handles to public keys and personal address data.

The protocol differences from bitcoin include:

* Different blockchain, port, IRC bootstrap, dnsseed and message header
* New transaction types: new, first-update, update
* Validation on the new transaction types
* RPC calls for managing names
* Increased network fees to slow down the initial rush and to reward miners.

Please read DESIGN-611d.md for details.


Build from Source
======================

Build from source code is supported on Linux, Windows and Mac (and probably all other \*nix compatible systems).
The /doc folder is providing detailed build instructions for Linux, Windows and Mac OSX. 
