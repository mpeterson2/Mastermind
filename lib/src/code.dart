part of Mastermind;

class Code {
  
  List<int> digits;

  Code(this.digits);
  
  Code.fromStr(String str) {
    List<String> digitStrs = str.split(" ");
    digits = digitStrs.map((String s) => int.parse(s)).toList();    
  }
  
  /**
   * Get the number of matching digits and positions from a different Code.
   */
  int matchCorrect(Code other) {
    int matching = 0;
    
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
  int matchClose(Code other) {
    int matching = 0;

    List<int> countedThis = new List<int>();
    List<int> countedOther = new List<int>();
    

    // Be sure that we aren't counting any correct hits.
    for(int i=0; i<length; i++) {
      if(this[i] == other[i]) {
        countedThis.add(i);
        countedOther.add(i);
      }
    }
    
    // Get all the close matches.
    for(int i=0; i<length; i++) {
      for(int j=0; j<length; j++) {
        if(this[i] == other[j] &&
           !countedThis.contains(i) && !countedOther.contains(j)) {
          countedThis.add(i);
          countedOther.add(j);
          matching++;
        }
        
      }
    }
    
    return matching;
  }

  int get length {
    return digits.length;
  }
  
  operator [](int i) {
    return digits[i];
  }
  
  operator ==(Code other) {
    for(int i=0; i<length; i++) {
      if(this[i] != other[i])
        return false;
    }
    
    return true;
  }
  
  String toString() {
    String str = "";
    
    for(int d in digits) {
      str += "$d, ";
    }
    
    // Remove the last comma and space.
    str = str.substring(0, str.length - 2);
    
    return str;
  }
}