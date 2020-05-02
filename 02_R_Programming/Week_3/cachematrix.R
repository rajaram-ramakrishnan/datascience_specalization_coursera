## These functions create a matrix and then perform inverse of it 
## using solve function. It also caches the inverse


## This function creates a matrix object and then inverse it.
## This function returns a list containing four functions
## set => set the matrix
## get => get the matrix
## setinv => set the inverse matrix
## getinv => get the inverse matrix

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  
  ## Set function to define matrix. This method is used to overwrite
  ## existing matrix(x) and clears inverse matrix(inv)
  set <- function(y){
    x <<- y
    inv <<- NULL
  }
  
  ## get function to retrive the contents of the matrix which has been
  ## set using makeCacheMatrix call or set function
  get <- function() {x}
  
  ## setinverse function to set the inverse matrix (inv) in cache
  setinverse <- function(inverse) { inv <<- inverse}
  
  ## getinverse function to get the inverse matrix(inv) from
  ## cache
  getinverse <- function() {inv}
  
  ## Return a list with above 4 functions
  list(set = set,
       get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This functions calculates the inverse of the matrix set by makeCacheMatrix
## and if inverse already available it gets 
## from cache. If not it calculates and set to the cache so that next time 
## it can retrive from cache

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  ## Gets the Inverse matrix from cache
  invmat <- x$getinverse()
  
  ## check if invmat is null. If its not null, retrive the inverse matrix
  ## from cache and return
  if (!is.null(invmat)){
    message("getting cached inverse matrix")
    return(invmat)
  }
  
  ## get the matrix input
  mat <- x$get()
  
  ## calculate inverse of matrix using solve
  invmat <- solve(mat,...)
  
  ## set the invesre matrix cache and returns inverse matrix
  x$setinverse(invmat)
  invmat
}
