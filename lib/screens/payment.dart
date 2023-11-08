import 'package:flutter/material.dart';

class DonationScreen extends StatefulWidget {
  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  double _donationAmount = 0.0;
  String _paymentMethod = '';

  Color getTextColor(String method) {
    return _paymentMethod == method ? Color(0xFF2EDC21) : Colors.black;
  }

  void _showPaymentDialog() {
    if (_donationAmount > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Payment Method: ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _paymentMethod = 'Google Pay';
                            });
                            Navigator.pop(context); // Close the dialog
                            _navigateToPaymentPage();
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/juice.jpg',
                                    height: 60,
                                    width: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _paymentMethod = 'PayPal';
                            });
                            Navigator.pop(context); // Close the dialog
                            _navigateToPaymentPage();
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/paypal.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void _navigateToPaymentPage() {
    if (_paymentMethod == 'Google Pay') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JuicePage(donationAmount: _donationAmount),
        ),
      );
    } else if (_paymentMethod == 'PayPal') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PayPalPage(donationAmount: _donationAmount),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
        backgroundColor: Color(0xFF1F3D1D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/donate.png',
              width: 250.0,
              height: 250.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Enter Donation Amount:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 35.0), // Adjust the left padding value as needed
                  child: Container(
                    width: 200,
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _donationAmount = double.parse(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showPaymentDialog();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.green,
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


class JuicePage extends StatefulWidget {
  final double donationAmount;

  JuicePage({required this.donationAmount});

  @override
  _JuicePageState createState() => _JuicePageState();
}

class _JuicePageState extends State<JuicePage> {
  TextEditingController _accountNumberController = TextEditingController();
  bool _isValidAccountNumber = false;

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  bool validateAccountNumber(String accountNumber) {
    return accountNumber.length == 14;
  }

  void showErrorMessage() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text("Incorrect Account Number!"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay local MCB Account'),
        backgroundColor: Color(0xFF761a51),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Column(
                children: [
                  Image.asset(
                    'assets/images/juice.jpg',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to Juice',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Donation Amount: ${widget.donationAmount}'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _accountNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Account Number',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isValidAccountNumber = validateAccountNumber(value);
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Date of Expiry',
                        hintText: 'dd/mm',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isValidAccountNumber
                    ? () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Done'),
                        content: Text('Payment successful!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close',style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1F3D1D)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                    : showErrorMessage, // Show error message box
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF761a51)),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PayPalPage extends StatefulWidget {
  final double donationAmount;

  PayPalPage({required this.donationAmount});

  @override
  _PayPalPageState createState() => _PayPalPageState();
}

class _PayPalPageState extends State<PayPalPage> {
  TextEditingController _accountNumberController = TextEditingController();
  bool _isValidAccountNumber = false;

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  bool validateAccountNumber(String accountNumber) {
    return accountNumber.length == 14;
  }

  void showErrorMessage() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text("Incorrect Account Number!"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayPal'),
        backgroundColor: Color(0xFF002c8d),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Column(
                children: [
                  Image.asset(
                    'assets/images/paypal.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to PayPal',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Donation Amount: ${widget.donationAmount}'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _accountNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Account Number',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isValidAccountNumber = validateAccountNumber(value);
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Date of Expiry',
                        hintText: 'dd/mm',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isValidAccountNumber
                    ? () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Done'),
                        content: Text('Payment successful!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close',style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1F3D1D)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                    : showErrorMessage, // Show error message box
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF002c8d)),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}