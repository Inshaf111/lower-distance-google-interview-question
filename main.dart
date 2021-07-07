void main() {
  List<String> reqs = ["gym", "school", "store"];

  List<Map> blocks = [
    {
      "name": "building 1",
      "gym": false,
      "school": true, //1 [0,1,0] - 5 == [1,0,4]
      "store": false,
    },
    {
      "name": "building 2",
      "gym": true,
      "school": false, //1 [1,0,0] - 4 == [0,1,3]
      "store": false,
    },
    {
      "name": "building 3",
      "gym": true,
      "school": true, //2 [1,1,0] - 2 == [0,0,2]
      "store": false,
    },
    {
      "name": "building 4",
      "gym": false,
      "school": true, //1 [0,1,0] - 2  == [1,0,1]
      "store": false,
    },
    {
      "name": "building 5",
      "gym": false,
      "school": true, //2 [0,1,1] - 2 == [2,0,0]
      "store": true,
    },
  ];

  //[1,0,4]  - 4
  //[0,1,3]  - 3
  //[0,0,2]  - 2  ==> Maxiumums [4,3,2,1,2] ==> Min Index 4 (1)
  //[1,0,1]  - 1
  //[2,0,0]  - 2

  List<List<int>> blocDistanceList = []; //all bloc's distances
  List<int> maxValues = [];
  int minValue;

  for (int i = 0; i < blocks.length; i++) {
    //checking blocs
    List<int> distances = [];

    for (int j = 0; j < reqs.length; j++) {
      //checking reqs

      int distanceCount = 0;
      String currentReq = reqs[j];

      if (blocks[i][currentReq] == true) {
        distances.add(0);
      } else {
        if (i == 0) {
          // only for first bloc
          int m = 1;
          while (m < blocks.length) {
            //checking in next obs

            if (blocks[m][currentReq] == true) {
              distanceCount = m - i;
              break;
            }
            m++;
          }
        } else {
          //if not first obj
          List disBySides = [];
          //==========================>
          int m = i + 1;
          while (m < blocks.length) {
            //checking in next obs

            if (blocks[m][currentReq] == true) {
              distanceCount = m - i;
              disBySides.add(distanceCount);
              break;
            }
            m++;
          }

          // <===========================
          int n = i - 1;
          while (n >= 0) {
            //checking in next obs

            if (blocks[n][currentReq] == true) {
              distanceCount = i - n;
              disBySides.add(distanceCount);
              break;
            }
            n--;
          }

          //get the min distance from both sides
          if (disBySides.length == 1) {
            //if there is only one side
            distanceCount = disBySides[0];
          } else {
            distanceCount =
                disBySides.reduce((curr, next) => curr < next ? curr : next);
          }
        }
        distances.add(distanceCount);
      }
    }
    blocDistanceList.add(distances);
  }

  //get the max of all distances
  for (int i = 0; i < blocks.length; i++) {
    maxValues.add(
        blocDistanceList[i].reduce((curr, next) => curr > next ? curr : next));
  }

  // get the minimum val from max values
  minValue = maxValues.reduce((curr, next) => curr < next ? curr : next);
  int minIndex = maxValues.indexOf(minValue);

  print(maxValues);
  print(blocks[minIndex]["name"]);
}
