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

    // Hold the already counted hits.
    List<int> countedThis = new List<int>();
    List<int> countedOther = new List<int>();
    

    // Be sure that we aren't counting any correct hits.
    for(int i=0; i<length; i++) {
      if(this[i] == other[i]) {
        countedThis.add(i);
        countedOther.add(i);
      }
    }
    
    //Check each digit in the 2 codes against each other.
    for(int i=0; i<length; i++) {
      for(int j=0; j<length; j++) {
        
        // If we have a match and it has not already been counted.
        if(this[i] == other[j] &&
           !countedThis.contains(i) && !countedOther.contains(j)) {
          // Count it.
          countedThis.add(i);
          countedOther.add(j);
          matching++;
        }
        
      }
    }
    
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