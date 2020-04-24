import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChangeColorModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class ChangeColorModel with ChangeNotifier {
  RadioListValue _value = new RadioListValue(0, Colors.green[500], "Green");
  RadioListValue get currentValue => _value;

  void chageModel(RadioListValue m) {
    _value = m;
    notifyListeners();
  }
}

class RadioListValue {
  final int key;
  final Color color;
  final String label;
  RadioListValue(this.key, this.color, this.label);
}

class HomePage extends StatelessWidget {
  final _buttonOptions = [
    RadioListValue(0, Colors.green[500], "Green"),
    RadioListValue(1, Colors.red, "Red"),
    RadioListValue(2, Colors.pink, "Pink"),
    RadioListValue(3, Colors.black38, "Black"),
    RadioListValue(4, Colors.yellow, "Yellow"),
    RadioListValue(5, Colors.brown, "Brown"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Consumer<ChangeColorModel>(builder: (context, model, _) {
        return Container(
          color: model.currentValue.color,
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: _buttonOptions
                .map(
                  (timeValue) => RadioListTile(
                    groupValue: model.currentValue.key,
                    title: Text(timeValue.label),
                    value: timeValue.key,
                    onChanged: (val) {
                      model.chageModel(_buttonOptions[val]);
                    },
                  ),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
