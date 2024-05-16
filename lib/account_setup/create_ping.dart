import 'package:flutter/material.dart';
import 'package:umoja/account_setup/select_interest_success.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({Key? key}) : super(key: key);

  @override
  _CreatePinPageState createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  List<String> _pin = [];
  final _formKey = GlobalKey<FormState>();

  void _addPinDigit(String digit) {
    setState(() {
      if (_pin.length < 4) {
        _pin.add(digit);
      }
    });
  }

  void _removePinDigit() {
    setState(() {
      if (_pin.isNotEmpty) {
        _pin.removeLast();
      }
    });
  }

  void _createPin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Submit the PIN to your backend
      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectInterestPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Create Your PIN'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Please remember this PIN because it will be used when you want to top up, withdraw, or donate.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              Text(
                'Create PIN',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 20.0,
                    height: 20.0,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _pin.length > index
                          ? Colors.green
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0),

              CustomBouton(
                label: "Create PIN",
                onPressed: _createPin,
                ),
  
              SizedBox(height: 32.0),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: [
                    _buildNumberButton('1'),
                    _buildNumberButton('2', label: 'ABC'),
                    _buildNumberButton('3', label: 'DEF'),
                    _buildNumberButton('4', label: 'GHI'),
                    _buildNumberButton('5', label: 'JKL'),
                    _buildNumberButton('6', label: 'MNO'),
                    _buildNumberButton('7', label: 'PQRS'),
                    _buildNumberButton('8', label: 'TUV'),
                    _buildNumberButton('9', label: 'WXYZ'),
                    _buildSymbolButton(),
                    _buildNumberButton('0'),
                    _buildDeleteButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number, {String? label}) {
    return ElevatedButton(
      onPressed: () {
        _addPinDigit(number);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        textStyle: TextStyle(fontSize: 20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number),
          if (label != null) Text(label, style: TextStyle(fontSize: 12.0)),
        ],
      ),
    );
  }

  Widget _buildSymbolButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Handle symbol input
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        textStyle: TextStyle(fontSize: 20.0),
      ),
      child: Text('+ * #'),
    );
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      onPressed: _removePinDigit,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
      ),
      child: Icon(Icons.backspace),
    );
  }
}