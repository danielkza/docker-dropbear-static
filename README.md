# docker-dropbear-static

Minimal Docker image containing static [Dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html)
binaries with musl libc (built in Alpine Linux).

Dropbear is a relatively small SSH server and client. It runs on a variety of POSIX-based platforms.

## Usage

```bash
# Run SSH client
docker run -it danielkza/dropbear-static ssh my-host

# Run SSH server
docker run -p 2022:22 dropbear-static
```

## Incorporating in builds

Since the Dropbear executables are self-contained, they can be copied to other images at will.

```Dockerfile
FROM danielkza/dropbear-static AS dropbear

FROM debian:stretch

# Use dropbear instead of installing OpenSSH
COPY --from=dropbear /bin/ /usr/local/bin/
COPY --from=dropbear /etc/dropbear /etc/dropbear
```

## License (MIT)

Copyright (c) 2019 Daniel Miranda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
