import 'package:flutter/material.dart';
import 'package:minimalisticpush/controllers/controllers.dart';
import 'package:minimalisticpush/models/session.dart';
import 'package:minimalisticpush/screens/screens.dart';
import 'package:minimalisticpush/widgets/widgets.dart';

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  List<Widget> sessionWidgets = [];
  var sessions;

  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    super.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            LocationText(
              text: 'Training Mode',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.toc,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // show sessions

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SessionsScreen()));

                    Screen.instance.pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutQuart,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // show settings
                    Screen.instance.pageController.animateToPage(
                      2,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutQuart,
                    );
                  },
                )
              ],
            )
          ],
        ),
        Spacer(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: _incrementCounter,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(_counter.toString()),
              ),
            ),
          ),
        ),
        Spacer(),
        CustomButton(
          text: 'Add session to database',
          onTap: () {
            if (_counter >= 1) {
              SessionController.instance
                  .insertSession(Session(count: _counter));
              _counter = 0;
              this.setState(() {});
            } else {
              this._showDialog();
            }
          },
        ),
        CustomButton(
          text: 'Clear counter',
          onTap: () {
            _counter = 0;
            this.setState(() {});
          },
        ),
      ],
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Already done?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('It seems like your counter is still at 0.'),
                Text('Please finish you session.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              child: Text(
                'Okay.',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}