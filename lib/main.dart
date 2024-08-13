import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.brown),
    home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double age = 0.0;
  int? selectedYear;
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation = animationController as Animation<double>;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _showPicker() {
    showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: DateTime(2004),
        lastDate: DateTime.now()).then((DateTime? dt) {
      if (dt != null) {
        selectedYear = dt.year;
        calculateAge();
      }
    });
  }

  void calculateAge() {
    setState(() {
      age = (DateTime.now().year - selectedYear!).toDouble();
      animation = Tween<double>(begin: animation.value, end: age).animate(
          CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));

      animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Calculator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              child: Text(selectedYear != null
                  ? selectedYear.toString()
                  : "Select your year of birth"),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black, width: 3.0),
              ),
              onPressed: _showPicker,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Text(
                "Your Age is ${animation.value.toStringAsFixed(0)}",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}
