part of Mastermind;

class Permutation {
  static List<List<int>> permutate(int maxNum, int size) {
    // create a list of nums from 0 to maxNum.
    final nums = new List.generate(maxNum + 1, (int i) => i);
  
    // init result with a list of nums [[0],[1],[2],[3]]
    Iterable<List> result = nums.map((int i) => [i]);
    for (int i = 1; i < size; i++) {
      // every step adds a new element to the result
      // [[0],[1],...] becomes [[0,0],[0,1],[1,0],[1,1],...]
      result = result.expand((List<int> e) => nums.map((int n) => e.toList()..add(n)));
    }
    return result.toList();
  }
}