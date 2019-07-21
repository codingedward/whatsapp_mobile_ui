import 'package:flutter/material.dart';
import 'package:whatsapp/screens/signup/dialogs/invalid_phone_number_dialog.dart';
import 'package:whatsapp/screens/signup/phone_verification.dart';

import 'countries.dart';
import 'country_search_delegate.dart';
import 'dialogs/confirm_phone_number_dialog.dart';
import '../../services/country_detection_service.dart';
import '../../services/phone_number_format_service.dart';

class SignUp extends StatefulWidget {
  final countries = Countries();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Country _selectedCountry;
  final _phoneNumberFocusNode = FocusNode();
  final _dialCodeTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setSelectedCountry(widget.countries.getBy(field: CountryField.CODE, value: 'KE'));
    _initDefaultCountryFromLocale();
    _dialCodeTextController.addListener(_onCountryCodeChanged);
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _dialCodeTextController.dispose();
    _phoneNumberTextController.dispose();
    super.dispose();
  }

  void _onCountryCodeChanged() {
    final text = _dialCodeTextController.text;
    if (_selectedCountry.code != text) {
      Country selected = widget.countries.getBy(
        field: CountryField.DIAL, 
        value: text
      );
      if (selected == null) {
        selected = Country(name: '(invalid country code)', code: '', flag: '', dial: text);
      }  else {
        FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
      }
      _dialCodeTextController.removeListener(_onCountryCodeChanged);
      _setSelectedCountry(selected);
      _dialCodeTextController.addListener(_onCountryCodeChanged);
    }
  }

  void _initDefaultCountryFromLocale() {
    CountryDetectionService.instance.detect(
      onFail: (error) {
        _setSelectedCountry(widget.countries.getBy(
          field: CountryField.CODE,
          value: 'KE',
        ));
      },
      onSuccess: (countryCode) {
        _setSelectedCountry(widget.countries.getBy(
          field: CountryField.CODE,
          value: countryCode,
        ));
      }
    );
  }

  void _onSearchCountryDelegateClosed(Country country) {
    _setSelectedCountry(country);
    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
  }

  void _setSelectedCountry(Country country) {
    if (country != null) {
      setState(() {
        _selectedCountry = country;
        _dialCodeTextController.value = _dialCodeTextController.value.copyWith(
          text: _selectedCountry.dial,
        );
      });
    }
  }

  Future<void> _onNext(BuildContext context) async {
    String dialCode = _dialCodeTextController.text;
    String phoneNumber = _phoneNumberTextController.text;
    String fullPhoneNumber = '+$dialCode$phoneNumber';

    bool isValid = await PhoneNumberFormatService.instance.isValid(
      phoneNumber: fullPhoneNumber,
      countryCode: _selectedCountry.code,
    );

    if (isValid) {
      showDialog(
        context: context,
        builder: (context) {
          return ConfirmPhoneNumberDialog(
            phoneNumber: fullPhoneNumber,
            onOK: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PhoneVerification(
                  phoneNumber: fullPhoneNumber,
                ))
              );
            }
          );
        }
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return InvalidPhoneNumberDialog(
            countryName: _selectedCountry.name,
          );
        }
      );
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
              _buildSignUpMessage(),
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
                              Center(child: Text(_selectedCountry.name, style: TextStyle(fontSize: 16))),
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
                                  controller: _dialCodeTextController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              focusNode: _phoneNumberFocusNode,
                              controller: _phoneNumberTextController,
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
                  _onNext(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpMessage() {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Verify your phone number',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff075e54),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: Text(
            'WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number. '
            'Enter your country code and phone number:'
          ),
        ),
      ],
    );
  }
}
