# Docker-611

611 (SixEleven) uses peer-to-peer technology to operate with no central authority or banks; managing transactions and the issuing of 611 (coin: SIL) is carried out collectively by the network. 611 is open-source. Its design is public, nobody owns or controls 611 and everyone can take part. Through many of its unique properties, 611 allows exciting uses that could not be covered by any previous payment and domain name system.

This Docker image provides `611d` application which can be used to run and interact with the 611 (SixEleven) network.

It loads the latest version of 611 (SixEleven) from git and creates an up-to-date docker image ready to run for you.


**Usage**

To start a 611 (SixEleven) instance running the latest version:

```
$ docker run --name some-sixeleven fflo/sixeleven
```

To run a 611 (SixEleven) container in the background, pass the `-d` option to `docker run`:

```
$ docker run -d --name some-sixeleven fflo/sixeleven
```

Once you have a 611 (SixEleven) service running in the background, you can show running containers:

```
$ docker ps
```

Or view the logs of a service:

```
$ docker logs -f some-sixeleven
```

To stop and restart a running container:

```
$ docker stop some-sixeleven
$ docker start some-sixeleven
```

**Data Volumes**

By default, Docker will create ephemeral containers. That is, the blockchain data will not be persisted if you create a new 611 (SixEleven) container.

To create a simple `busybox` data volume and link it to a 611 (SixEleven) service:

```
$ docker create -v /sixeleven --name sixeleven-data busybox /bin/true
$ docker run --volumes-from=sixeleven-data --name=sixeleven-node -d -p 8661:8661 -p 127.0.0.1:8663:8663 fflo/sixeleven
```

**Configuring 611 (SixEleven)**

The easiest method to configure the 611 (SixEleven) server is to pass arguments to the `611d` command. For example, to run 611 through localhost tor socks proxy on port 9050:

```
$ docker run --name sixeleven-node fflo/sixeleven 611d -proxy=127.0.0.1:9050
```

**Debug / Logfile**

By default, 611 (SixEleven) service 611d will dump any log information to the Docker logs. To debug use:

Warning: In case you did not define $SIXELEVEN_RPC_USER and $SIXELEVEN_RPC_PASSWORD, on first init a random password for rpc access will be generated. The output of the 611.conf configuration file will be dumped to the Docker logs on startup.

```
$ docker logs -t sixeleven-node
```
