import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

import 'countries.dart';
import 'country_search_delegate.dart';
import '../home/home.dart';
import '../signup/signup_message.dart';

class SignUp extends StatefulWidget {
  final countries = Countries();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Country _country;
  final _phoneNumberFocusNode = FocusNode();
  final _countryCodeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setSelectedCountry(widget.countries.getBy(field: CountryField.CODE, value: 'KE'));
    _initDefaultCountryFromLocale();
  }

  Future<void> _initDefaultCountryFromLocale() async {
    String countryCode;
    try {
      countryCode = await FlutterSimCountryCode.simCountryCode;
    } on PlatformException {
      countryCode = 'KE';
    }

    if (!mounted) return;

    _setSelectedCountry(widget.countries.getBy(
      field: CountryField.CODE,
      value: countryCode,
    ));
  }

  void _onSearchCountryDelegateClosed(Country country) {
    _setSelectedCountry(country);
    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
  }

  void _setSelectedCountry(Country country) {
    if (country != null) {
      setState(() {
        _country = country;
        _countryCodeTextController.text = _country.dial;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SignUpMessage(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CountrySearchDelegate(
                              countries: widget.countries,
                              onClose: _onSearchCountryDelegateClosed,
                            )
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey),)
                          ),
                          child: Stack(
                            children: <Widget>[
                              Center(child: Text(_country.name, style: TextStyle(fontSize: 16))),
                              Positioned(
                                right: 0,
                                child: Icon(Icons.arrow_drop_down,
                                color: Colors.grey)
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 60,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 0,
                                  bottom: 10,
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  )
                                ),
                                TextField(
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  controller: _countryCodeTextController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              focusNode: _phoneNumberFocusNode,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'phone number',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                color: Color(0xff25d366),
                child: Text('NEXT', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
