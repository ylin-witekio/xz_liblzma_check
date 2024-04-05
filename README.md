# XZ LibLZMA Check

This is a simple utility script that checks if the executables on your machine are dynamically linked to compromised versions of liblzma (5.6.0 and 5.6.1).

## Usage
#### `curl` one line download and check of `/usr/bin/`
```
curl https://raw.githubusercontent.com/ylin-witekio/xz_liblzma_check/main/xz_liblzma_check.sh | bash
```

#### `wget` one line download and check of `/usr/bin/`
```
wget -O - https://raw.githubusercontent.com/ylin-witekio/xz_liblzma_check/main/xz_liblzma_check.sh | bash
```

## Advanced Usage
```
git clone git@github.com:ylin-witekio/xz_liblzma_check.git
cd xz_liblzma_check
chmod +x ./xz_liblzma_check.sh
```

#### Check of /usr/bin/
```
./xz_liblzma_check.sh
```

#### Check of arbitrary directory
```
./xz_liblzma_check.sh /opt/bin/
```