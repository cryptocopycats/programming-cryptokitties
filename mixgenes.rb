require 'base32-alphabets'


genome = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

genes_num = Base32.bytes( genome )
p genes_num
#=> [9, 9, 9, 9, 6, 7, 7, 4, 1, 1, 14, 1, 9, 15, 14, 14, 0, 5, 5, 0, 6, 6, 4, 4, 13, 8, 6, 8, 1, 3, 3, 0, 5, 5, 5, 6, 6, 5, 5, 3, 9, 8, 9, 9, 11, 14, 14, 14]
p genes_num.size
#=> 48
p genes_num.reverse
#=> [14, 14, 14, 11, 9, 9, 8, 9, 3, 5, 5, 6, 6, 5, 5, 5, 0, 3, 3, 1, 8, 6, 8, 13, 4, 4, 6, 6, 0, 5, 5, 0, 14, 14, 15, 9, 1, 14, 1, 1, 4, 7, 7, 6, 9, 9, 9, 9]



def mixgenes( mgenes, sgenes )  ## returns babygenes
  babygenes = []

  # PARENT GENE SWAPPING
  for i in 0.step(11,1) do ## loop from 0 to 11    # for(i = 0; i < 12; i++)
    index = 4 * i                                  #    index = 4 * i
    for j in 3.step(1,-1) do  ## loop from 3 to 1  #   for (j = 3; j > 0; j--)
      if rand() < 0.25                             #     if random() < 0.25:
        mgenes[index+j-1], mgenes[index+j] =       #       swap(mGenes, index+j, index+j-1)
        mgenes[index+j],   mgenes[index+j-1]
      end
      if rand() < 0.25                             #     if random() < 0.25:
        sgenes[index+j-1], sgenes[index+j] =       #        swap(sGenes, index+j, index+j-1)
        sgenes[index+j],   sgenes[index+j-1]
      end
    end
  end

  # BABY GENES
  for i in 0.step(47,1) do ## loop from 0 to 47    #  for (i = 0; i < 48; i++):
    mutation = nil                                 #    mutation = 0
    # CHECK MUTATION
    if i % 4 == 0                                  #    if i % 4 == 0:
      gene1 = mgenes[i]                            #      gene1 = mGenes[i]
      gene2 = sgenes[i]                            #      gene2 = sGenes[i]
      if gene1 > gene2                             #      if gene1 > gene2:
         gene1, gene2 = gene2, gene1               #        gene1, gene2 = gene2, gene1
      end
      if (gene2 - gene1) == 1 && gene1.even?       #     if (gene2 - gene1) == 1 and iseven(gene1):
        probability = 0.25                         #        probability = 0.25
        if gene1 > 23                              #        if gene1 > 23:
          probability /= 2                         #          probability /= 2
        end
        if rand() < probability                    #        if random() < probability:
          mutation = (gene1 / 2) + 16              #          mutation = (gene1 / 2) + 16
        end
      end
    end
    # GIVE BABY GENES
    if mutation                                    #    if mutation:
      babygenes[i] = mutation                      #      babyGenes[i] = mutation
    else                                           #    else:
      if rand() < 0.5                              #      if random() < 0.5:
        babygenes[i] = mgenes[i]                   #        babyGenes[i] = mGenes[i]
      else                                         #      else:
        babygenes[i] = sgenes[i]                   #        babyGenes[i] = sGenes[i]
      end
    end
  end

  babygenes   # return bagygenes
end # mixgenes


mgenome = 0x000063169218f348dc640d171b000208934b5a90189038cb3084624a50f7316c
sgenome = 0x00005a13429085339c6521ef0300011c82438c628cc431a63298e3721f772d29

mgenes = Base32.bytes( mgenome ).reverse
sgenes = Base32.bytes( sgenome ).reverse
p mgenes
#=> [12, 11, 12, 14, 15, 8, 9, 9, 2, 3, 1, 1, 19, 5, 3, 7, 16, 4, 6, 0, 9, 13, 13, 9, 19, 4, 2, 4, 0, 0, 12, 3, 23, 8, 3, 8, 6, 14, 3, 9, 19, 7, 6, 4, 9, 11, 12, 12]
p sgenes
#=> [9, 9, 11, 14, 23, 15, 8, 14, 3, 7, 6, 5, 3, 19, 6, 6, 4, 6, 3, 5, 6, 6, 14, 8, 2, 4, 7, 2, 0, 0, 12, 0, 15, 15, 8, 10, 6, 14, 14, 6, 5, 4, 4, 5, 20, 9, 8, 11]


##############################
# note: use "deterministic" seed for rand(om) - for testing always gets same rand(om) numbers
srand( 123 )

babygenes1 = mixgenes( mgenes, sgenes )
p babygenes1
#=> [9, 9, 11, 14, 23, 8, 9, 14, 3, 3, 5, 1, 3, 19, 3, 7, 16, 4, 6, 5, 9, 6, 14, 8, 19, 4, 2, 4, 0, 0, 12, 3, 23, 15, 8, 10, 6, 14, 3, 9, 19, 5, 6, 5, 20, 9, 11, 8]

babygenes2 = mixgenes( mgenes, sgenes )
p babygenes2
#=> [12, 9, 11, 11, 15, 23, 9, 9, 5, 2, 3, 6, 3, 19, 5, 6, 4, 4, 3, 5, 9, 6, 13, 9, 19, 4, 7, 4, 0, 0, 12, 12, 15, 3, 8, 10, 6, 3, 14, 9, 19, 5, 5, 4, 9, 9, 11, 8]

babygenes3 = mixgenes( mgenes, sgenes )
p babygenes3
#=> [12, 12, 14, 11, 15, 23, 8, 14, 3, 1, 3, 1, 19, 3, 7, 6, 16, 5, 6, 3, 6, 6, 13, 9, 19, 4, 2, 4, 0, 0, 0, 12, 23, 3, 8, 8, 6, 6, 14, 14, 4, 19, 6, 7, 9, 12, 9, 11]


babygenes1_kai = Base32.encode( babygenes1.reverse )
p babygenes1_kai
#=> "9cam676ka4f7b9gp4d11535k9f7a675h84k42644fa9pfcaa"

babygenes2_kai = Base32.encode( babygenes2.reverse )
p babygenes2_kai
#=> "9caa566kaf47b94gdd11585kae7a645576k47436aapgccad"

babygenes3_kai = Base32.encode( babygenes3.reverse )
p babygenes3_kai
#=> "cada87k5ff77994pd111535kae77476h784k2424f9pgcfdd"
