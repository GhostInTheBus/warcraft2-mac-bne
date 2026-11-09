# Disc images

If you have a bin/cue image instead of a mounted disc, the data track is usually MODE1/2352. Each 2352 byte sector holds a 16 byte header, 2048 bytes of data, then error correction bytes. Take the 2048 bytes from each sector and you have a normal ISO:

```python
import sys
src, dst = sys.argv[1], sys.argv[2]
with open(src, "rb") as f, open(dst, "wb") as o:
    while (s := f.read(2352)):
        o.write(s[16:16 + 2048])
```

Mount the resulting ISO (double click it in Finder) and copy `INSTALL.EXE` and the `SUPPORT` folder into `bne_data/`.
