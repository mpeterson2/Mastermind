part of Mastermind;

/**
 * A class for permutating.
 */
class Permutation {
  
  /**
   * Create a list of lists that holds maxElements amount of ints, with values from 0 to maxNum.
   */
  static List<List<int>> permutate(int maxNum, int maxElements) {
    return _actualPermutate(maxNum+1, maxElements);
  }
  
  /**
   * The actual permutating goes on here.
   * 
   * I had a bit of help on this one from stackoverflow.
   * (http://stackoverflow.com/questions/22631345/how-to-make-a-list-of-lists-of-n-numbers-including-x-z-numbers#22631911)
   * 
   * This is the second implementation of this. It is much faster, but less readable.
   */
  static List<List<int>> _actualPermutate(int maxNum, int size) {
    // create a list of nums [0,1,2,3]
    final nums = new List.generate(maxNum, (int i) => i);
  
    // init result with a list of nums [[0],[1],[2],[3]]
    Iterable<List> result = nums.map((int i) => [i]);
    for (int i = 1; i < size; i++) {
      // every step adds a new element to the result
      // [[0],[1],...] becomes [[0,0],[0,1],[1,0],[1,1],...]
      result = result.expand((List<int> e) => nums.map((int n) => e.toList()..add(n)));
    }
    return result;
  }
  
  /**
   * The actual permutating goes on here.
   * 
   * I had a bit of help on this one from stackoverflow.
   * (http://stackoverflow.com/questions/22631345/how-to-make-a-list-of-lists-of-n-numbers-including-x-z-numbers#22631911)
   * 
   * This is the first implementation of this that I had. It worked, but it wasn't as fast.
   */
  @deprecated
  static List<List<int>> _actualPermutateOld(int maxNum, int maxElements) {
    // Get the number of element in the list and create it.
    int resultCount = pow(maxNum, maxElements);
    List<List<int>> permutations = new List(resultCount);
  
    // cnt represents the current location in the outter list. 
    int cnt = 0;
    
    // The current list to add to.
    List<int> cur = new List<int>(maxElements);
    
    // Initially set everything to 0.
    for(int i = 0; i < maxElements; i++)
      cur[i] = 0;
  
    // While our first value hasn't hit our max value.
    while(cur[0] < maxNum) {
      // Add a new list to the permutations.
      permutations[cnt++] = new List.from(cur);
  
      // Change the position to add to the list to be one less than before.
      int pos = maxElements-1;
      
      // Add to the current list's current position
      cur[pos]++;
      
      // If we have an overflow, we have to fix that.
      bool overflow = cur[pos] >= maxNum;
      while(overflow && pos > 0) {
        // Set the current list's current value to 0.
        cur[pos] = 0;
        
        // Set the next value to 1 + what it was before.
        pos--;
        cur[pos]++;
        
        // Recheck for overflow.
        overflow = cur[pos] >= maxNum;
      }
    }
    
    // Finally return the list.
    return permutations;
  }
}