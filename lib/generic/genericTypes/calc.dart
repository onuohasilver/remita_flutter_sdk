main() {
  List<int> numbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
  ];
  int targetNumber = 27;

  ///finding the one that sums up to 1000

  bruteForce(numbers, targetNumber);
}

bruteForce(List<int> numbers, int targetNumber) {
  for (int index = 0; index < numbers.length; index++) {
    print('\n - \n');
    print(numbers[index]);

    ///First of all hold the current index as the entry point
    int currentValue = numbers[index];

    ///Make A copy of the list of numbers
    List<int> numbersReduced = [];
    numbersReduced.addAll(numbers);

    ///Remove The value of the current index
    numbersReduced.remove(numbers[index]);

    ///Sort from smallest to largest
    numbersReduced.sort();

    bool startLoop = true;
    while (startLoop) {
      ///Gets the index of the maximum number that can be added
      ///to the currentValue without exceeding the targetNumber
      ///Example if the target number is 1000 and the current Value is 600
      ///
      ///Given a list of [200,300,500,1000,700,100]
      ///
      ///indexToAdd will return the index of 300
      ///
      ///it returns -1 when there's mo index to satisfy this condition
      int indexToAdd = numbersReduced.lastIndexWhere(
          (element) => element <= (targetNumber - currentValue));
      if (indexToAdd != -1) {
        currentValue += numbersReduced[indexToAdd];
        print('Number to add ${numbersReduced[indexToAdd]}');

        ///When this is done, remove whatver value has been added
        ///and redo this loop
        numbersReduced.removeAt(indexToAdd);
      } else {
        print('Current Value Final: $currentValue');
        startLoop = false;
      }
    }
  }
}
