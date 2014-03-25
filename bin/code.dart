part of Mastermind;

/**
 * A list of numbers that represent a code.
 */
class Code {
  // The max value a digit in the code can be.
  static final int MAX_VAL = 5;
  
  List<int> digits;

  /**
   * Create a Code using a list of digits.
   */
  Code(this.digits);
  
  /**
   * Get the number of matching digits and positions from a different Code.
   */
  int numCorrect(Code other) {
    int matching = 0;
    
    // Loop through length times to see what matches we have.
    for(int i=0; i<length; i++) {
      // If this Code at i is equal to other Code at i, there is a match.
      if(this[i] == other[i])
        matching++;
    }
    
    // Return the number of correct matches.
    return matching;
  }
  
  /**
   * Get the number of matching digits, minus the correct digits
   * and positions, from a different Code.
   */
  int numClose(Code other) {
    int matching = 0;
    
    // Lists to hold what has already been counted, so we can skip it.
    List<int> thisCounted = new List<int>();
    List<int> otherCounted = new List<int>();
    
    // Be sure no correct pos and digits are added.
    for(int i=0; i<length; i++) {
      if(this[i] == other[i]) {
        thisCounted.add(i);
        otherCounted.add(i);
      }
    }
    
    // Check for matching digits.
    iloop:
    for(int i=0; i<length; i++) {
      
      jloop:
      for(int j=0; j<length; j++) {
        
        // Be sure that this number hasn't been counted for the other Code.
        for(int k in otherCounted) {
          // If it has been, continue at the jloop.
          if(k == j)
            continue jloop;
        }
        
        // Be sure that this number hasn't been counted for the this Code.
        for(int k in thisCounted) {
          // If it has been, continue at the iloop.
          if(k == i)
            continue iloop;
        }
        
        // Now we know that these numbers haven't been counted,
        // so check if it's a match.
        if(this[i] == other[j]) {
          // If i == j, this is a correct match, not a close match.
          // So count it (so it won't show up again) and continue.
          if(i == j) {
            thisCounted.add(this[i]);
            otherCounted.add(other[j]);
            continue;
          }
  
          // Otherwise, we know this is a close match, so count it and break
          // so we don't count it again.
          thisCounted.add(i);
          otherCounted.add(j);
          matching++;
          break;
        }
        
      }
    }
    
    // Return the number of close matches.
    return matching;
  }

  /**
   * Get the length of this Code.
   */
  int get length {
    return digits.length;
  }
  
  /**
   * Get a number of this Code at i.
   */
  operator [](int i) {
    return digits[i];
  }
  
  /**
   * Check whether or not this Code equals another Code.
   */
  operator ==(Code other) {
    // Run through and check for any differences.
    for(int i=0; i<length; i++) {
      if(this[i] != other[i])
        return false;
    }
    
    // If no differences are found, there's a match.
    return true;
  }
  
  /**
   * Display the Code in a really fancy way in the console.
   */
  String toString() {
    String str = "";
    
    // Add the value, a comma, and a space for each part of the code.
    for(int d in digits) {
      str += "$d, ";
    }
    
    // Remove the last comma and space.
    str = str.substring(0, str.length - 2);
    
    return str;
  }
}