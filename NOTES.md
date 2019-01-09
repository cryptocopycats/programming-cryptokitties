# Notes


## More CryptoKitties kittycalc Examples

Use 100% / purebreed (p, h1, h2, h3) trait genes example with - raisedbrow + fabulous => wingtips 

Find some cats:

- https://heaven.cat/find?order=0&eyetype=k@0,1,2,3   - raisedbrow (k)
- https://heaven.cat/find?order=0&eyetype=j@0,1,2,3   - fabulous (j)

- #145894 => raisedbrow (eyetype/eye shape/eyes)  100% / purebreed

```
  isGestating   bool :  false
  isReady   bool :  true
  cooldownIndex   uint256 :  7
  nextActionAt   uint256 :  4783071
  siringWithId   uint256 :  0
  birthTime   uint256 :  1512715630
  matronId   uint256 :  132835
  sireId   uint256 :  95618
  generation   uint256 :  12
  genes   uint256 :  518135065203089473330219788762794806684086479456502797768991880508810542
```

- #819830 => fabulous   (eyetype/eye shape/eyes)  100% / purebreed

```
  isGestating   bool :  false
  isReady   bool :  true
  cooldownIndex   uint256 :  5
  nextActionAt   uint256 :  0
  siringWithId   uint256 :  0
  birthTime   uint256 :  1529816212
  matronId   uint256 :  819423
  sireId   uint256 :  819778
  generation   uint256 :  10
  genes   uint256 :  623386483268689632668854739517122132573390084717816367014400099229274157
```

results in:

```
Eye Shape (ES) - 16 Mewtation Pair(s):
 14.06% | wingtips           | p+p   | fabulous+raisedbrow
  3.52% | wingtips           | p+h1  | fabulous+raisedbrow
  3.52% | wingtips           | h1+p  | fabulous+raisedbrow
  0.88% | wingtips           | h1+h1 | fabulous+raisedbrow
  0.88% | wingtips           | p+h2  | fabulous+raisedbrow
  0.88% | wingtips           | h2+p  | fabulous+raisedbrow
  0.29% | wingtips           | h3+p  | fabulous+raisedbrow
  0.29% | wingtips           | p+h3  | fabulous+raisedbrow
  0.22% | wingtips           | h1+h2 | fabulous+raisedbrow
  0.22% | wingtips           | h2+h1 | fabulous+raisedbrow
  0.07% | wingtips           | h1+h3 | fabulous+raisedbrow
  0.07% | wingtips           | h3+h1 | fabulous+raisedbrow
  0.05% | wingtips           | h2+h2 | fabulous+raisedbrow
  0.02% | wingtips           | h3+h2 | fabulous+raisedbrow
  0.02% | wingtips           | h2+h3 | fabulous+raisedbrow
  0.01% | wingtips           | h3+h3 | fabulous+raisedbrow
  
---

Eye Shape (ES):
 37.50% | raisedbrow
 37.50% | fabulous
 25.00% | wingtips
```

