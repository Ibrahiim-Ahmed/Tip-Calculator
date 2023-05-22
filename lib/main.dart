import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double billAmount = 0.0;
  double tipPercentage = 15.0;
  int splitCount = 1;

  double calculateTip() {
    return billAmount * (tipPercentage / 100);
  }

  double calculateTotalBill() {
    return billAmount + calculateTip();
  }

  double calculateBillPerPerson() {
    return calculateTotalBill() / splitCount;
  }

  double calculateTipPerPerson() {
    return calculateTip() / splitCount;
  }

  void incrementSplitCount() {
    setState(() {
      splitCount++;
    });
  }

  void decrementSplitCount() {
    if (splitCount > 1) {
      setState(() {
        splitCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Per Person",
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${calculateTotalBill().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      "Sub Total",
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${calculateBillPerPerson().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      "Per Person",
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${calculateTipPerPerson().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipPercentage = 10.0;
                    });
                  },
                  child: const Text('10%'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    primary: tipPercentage == 10.0
                        ? Colors.pinkAccent
                        : Colors
                            .grey, // Change the button color to dark pink if selected, otherwise grey
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipPercentage = 15.0;
                    });
                  },
                  child: const Text('15%'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    primary: tipPercentage == 15.0
                        ? Colors.pinkAccent
                        : Colors
                            .grey, // Change the button color to dark pink if selected, otherwise grey
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipPercentage = 20.0;
                    });
                  },
                  child: const Text('20%'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    primary: tipPercentage == 20.0
                        ? Colors.pinkAccent
                        : Colors
                            .grey, // Change the button color to dark pink if selected, otherwise grey
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Custom Tip Percentage'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    tipPercentage =
                                        double.tryParse(value) ?? 0.0;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Enter tip percentage',
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Custom'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    primary: Colors.grey, // Change the button color to grey
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  billAmount = double.tryParse(value) ?? 0.0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter bill amount',
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: decrementSplitCount,
                  child: const Icon(Icons.remove),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    shape: const CircleBorder(),
                    primary: Colors.pink,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    splitCount.toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: incrementSplitCount,
                  child: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    shape: const CircleBorder(),
                    primary: Colors.pink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
