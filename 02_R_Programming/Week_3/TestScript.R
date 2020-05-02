## This is test script to test inverse matrix cache

## create by passing a matrix to makeCacheMatrix
test_matrix <- makeCacheMatrix(matrix(1:4,nrow=2,ncol=2))

## check the contents of the test_matrix
test_matrix$get()

##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4

## Retrive the Inverse Matrix
test_matrix$getinverse()
## NULL

## Create Inverse matrix by calling cacheSolve
cacheSolve(test_matrix)
##         [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5

## Create Inverse matrix again by calling cacheSolve
cacheSolve(test_matrix)
## getting cached inverse matrix
##        [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5

## Get inverse matrix
test_matrix$getinverse()
##       [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5

## Set new matrix
test_matrix$set(matrix(11:14,nrow=2,ncol=2))

## check the contents of the test_matrix
test_matrix$get()
## [,1] [,2]
## [1,]   11   13
## [2,]   12   14

## Retrive the Inverse Matrix
test_matrix$getinverse()
## NULL

## Create Inverse matrix by calling cacheSolve
cacheSolve(test_matrix)
##        [,1] [,2]
## [1,]   -7  6.5
## [2,]    6 -5.5


## Create Inverse matrix again by calling cacheSolve
cacheSolve(test_matrix)
## getting cached inverse matrix
##        [,1] [,2]
## [1,]   -7  6.5
## [2,]    6 -5.5

## Get inverse matrix
test_matrix$getinverse()
##        [,1] [,2]
## [1,]   -7  6.5
## [2,]    6 -5.5