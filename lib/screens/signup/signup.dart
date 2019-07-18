import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_ui/screens/home/home.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

enum CountryField {
  FLAG,
  DIAL,
  NAME,
  CODE,
}

class Country {
  const Country({
    @required this.code,
    @required this.dial,
    @required this.flag,
    @required this.name,
  });

  final String code;
  final String dial;
  final String flag;
  final String name;

  String getField(CountryField field) {
    switch (field) {
      case CountryField.CODE: return code;
      case CountryField.DIAL: return dial;
      case CountryField.FLAG: return flag;
      case CountryField.NAME: return name;
      default: return '';
    }
  }
}

class Countries {
  List<Country> countries;

  final List<String> _flags = ['🇦🇩', '🇦🇪', '🇦🇫', '🇦🇬', '🇦🇮', '🇦🇱', '🇦🇲', '🇦🇴', '🇦🇶', '🇦🇷', '🇦🇸', '🇦🇹', '🇦🇺', '🇦🇼', '🇦🇽', '🇦🇿', '🇧🇦', '🇧🇧', '🇧🇩', '🇧🇪', '🇧🇫', '🇧🇬', '🇧🇭', '🇧🇮', '🇧🇯', '🇧🇱', '🇧🇲', '🇧🇳', '🇧🇴', '🇧🇶', '🇧🇷', '🇧🇸', '🇧🇹', '🇧🇻', '🇧🇼', '🇧🇾', '🇧🇿', '🇨🇦', '🇨🇨', '🇨🇩', '🇨🇫', '🇨🇬', '🇨🇭', '🇨🇮', '🇨🇰', '🇨🇱', '🇨🇲', '🇨🇳', '🇨🇴', '🇨🇵', '🇨🇷', '🇨🇺', '🇨🇻', '🇨🇼', '🇨🇽', '🇨🇾', '🇨🇿', '🇩🇪', '🇩🇬', '🇩🇯', '🇩🇰', '🇩🇲', '🇩🇴', '🇩🇿', '🇪🇦', '🇪🇨', '🇪🇪', '🇪🇬', '🇪🇭', '🇪🇷', '🇪🇸', '🇪🇹', '🇪🇺', '🇫🇮', '🇫🇯', '🇫🇰', '🇫🇲', '🇫🇴', '🇫🇷', '🇬🇦', '🇬🇧', '🇬🇩', '🇬🇪', '🇬🇫', '🇬🇬', '🇬🇭', '🇬🇮', '🇬🇱', '🇬🇲', '🇬🇳', '🇬🇵', '🇬🇶', '🇬🇷', '🇬🇸', '🇬🇹', '🇬🇺', '🇬🇼', '🇬🇾', '🇭🇰', '🇭🇲', '🇭🇳', '🇭🇷', '🇭🇹', '🇭🇺', '🇮🇨', '🇮🇩', '🇮🇪', '🇮🇱', '🇮🇲', '🇮🇳', '🇮🇴', '🇮🇶', '🇮🇷', '🇮🇸', '🇮🇹', '🇯🇪', '🇯🇲', '🇯🇴', '🇯🇵', '🇰🇪', '🇰🇬', '🇰🇭', '🇰🇮', '🇰🇲', '🇰🇳', '🇰🇵', '🇰🇷', '🇰🇼', '🇰🇾', '🇰🇿', '🇱🇦', '🇱🇧', '🇱🇨', '🇱🇮', '🇱🇰', '🇱🇷', '🇱🇸', '🇱🇹', '🇱🇺', '🇱🇻', '🇱🇾', '🇲🇦', '🇲🇨', '🇲🇩', '🇲🇪', '🇲🇫', '🇲🇬', '🇲🇭', '🇲🇰', '🇲🇱', '🇲🇲', '🇲🇳', '🇲🇴', '🇲🇵', '🇲🇶', '🇲🇷', '🇲🇸', '🇲🇹', '🇲🇺', '🇲🇻', '🇲🇼', '🇲🇽', '🇲🇾', '🇲🇿', '🇳🇦', '🇳🇨', '🇳🇪', '🇳🇫', '🇳🇬', '🇳🇮', '🇳🇱', '🇳🇴', '🇳🇵', '🇳🇷', '🇳🇺', '🇳🇿', '🇴🇲', '🇵🇦', '🇵🇪', '🇵🇫', '🇵🇬', '🇵🇭', '🇵🇰', '🇵🇱', '🇵🇲', '🇵🇳', '🇵🇷', '🇵🇸', '🇵🇹', '🇵🇼', '🇵🇾', '🇶🇦', '🇷🇪', '🇷🇴', '🇷🇸', '🇷🇺', '🇷🇼', '🇸🇦', '🇸🇧', '🇸🇨', '🇸🇩', '🇸🇪', '🇸🇬', '🇸🇭', '🇸🇮', '🇸🇯', '🇸🇰', '🇸🇱', '🇸🇲', '🇸🇳', '🇸🇴', '🇸🇷', '🇸🇸', '🇸🇹', '🇸🇻', '🇸🇽', '🇸🇾', '🇸🇿', '🇹🇦', '🇹🇨', '🇹🇩', '🇹🇫', '🇹🇬', '🇹🇭', '🇹🇯', '🇹🇰', '🇹🇱', '🇹🇲', '🇹🇳', '🇹🇴', '🇹🇷', '🇹🇹', '🇹🇻', '🇹🇼', '🇹🇿', '🇺🇦', '🇺🇬', '🇺🇸', '🇺🇾', '🇺🇿', '🇻🇦', '🇻🇨', '🇻🇪', '🇻🇬', '🇻🇮', '🇻🇳', '🇻🇺', '🇼🇫', '🇼🇸', '🇽🇰', '🇾🇪', '🇾🇹', '🇿🇦', '🇿🇲', '🇿🇼'];
  final List<String> _dials = ['376', '971', '93', '1-268', '1-264', '355', '374', '244', '672', '54', '1-684', '43', '61', '297', '-', '994', '387', '1-246', '880', '32', '226', '359', '973', '257', '229', '590', '1-441', '673', '591', '31', '55', '1-242', '975', '-', '267', '375', '501', '1', '61', '243', '236', '242', '41', '225', '682', '56', '237', '86', '57', '-', '506', '53', '238', '599', '61', '357', '420', '49', '-', '253', '45', '1-767', '1-809', '213', '-', '593', '372', '20', '212', '291', '34', '251', '-', '358', '679', '500', '691', '298', '33', '241', '44', '1-473', '995', '-', '44-1481', '233', '350', '299', '220', '224', '-', '240', '30', '-', '502', '1-671', '245', '592', '852', '-', '504', '385', '509', '36', '-', '62' , '353', '972', '44-1624', '91', '246', '964', '98', '354', '39', '44-1534', '1-876', '962', '81', '254', '996', '855', '686', '269', '1-869', '850', '82', '965', '1-345', '7', '856', '961', '1-758', '423', '94', '231', '266', '370', '352', '371', '218', '212', '377', '373', '382', '590', '261', '692', '389', '223', '95', '976', '853', '1-670', '-', '222', '1-664', '356', '230', '960', '265', '52', '60', '258', '264', '687', '227', '-', '234', '505', '599', '47', '977', '674', '683', '64', '968', '507', '51', '689', '675', '63', '92', '48', '508', '64', '1-787', '970', '351', '680', '595', '974', '262', '40', '381', '7', '250', '966', '677', '248', '249', '46', '65', '290', '386', '47', '421', '232', '378', '221', '252', '597', '211', '239', '503', '1-721', '963', '268', '-', '1-649', '235', '-', '228', '66', '992', '690', '670', '993', '216', '676', '90', '1-868', '688', '886', '255', '380', '256', '1', '598', '998', '379', '1-784', '58', '1-284', '1-340', '84', '678', '681', '685', '383', '967', '262', '27', '260', '263',];
  final List<String> _names = ['Andorra', 'United Arab Emirates', 'Afghanistan', 'Antigua & Barbuda', 'Anguilla', 'Albania', 'Armenia', 'Angola', 'Antarctica', 'Argentina', 'American Samoa', 'Austria', 'Australia', 'Aruba', 'Åland Islands', 'Azerbaijan', 'Bosnia & Herzegovina', 'Barbados', 'Bangladesh', 'Belgium', 'Burkina Faso', 'Bulgaria', 'Bahrain', 'Burundi', 'Benin', 'St. Barthélemy', 'Bermuda', 'Brunei', 'Bolivia', 'Caribbean Netherlands', 'Brazil', 'Bahamas', 'Bhutan', 'Bouvet Island', 'Botswana', 'Belarus', 'Belize', 'Canada', 'Cocos (Keeling) Islands', 'Congo - Kinshasa', 'Central African Republic', 'Congo - Brazzaville', 'Switzerland', 'Côte d’Ivoire', 'Cook Islands', 'Chile', 'Cameroon', 'China', 'Colombia', 'Clipperton Island', 'Costa Rica', 'Cuba', 'Cape Verde', 'Curaçao', 'Christmas Island', 'Cyprus', 'Czechia', 'Germany', 'Diego Garcia', 'Djibouti', 'Denmark', 'Dominica', 'Dominican Republic', 'Algeria', 'Ceuta & Melilla', 'Ecuador', 'Estonia', 'Egypt', 'Western Sahara', 'Eritrea', 'Spain', 'Ethiopia', 'European Union', 'Finland', 'Fiji', 'Falkland Islands', 'Micronesia', 'Faroe Islands', 'France', 'Gabon', 'United Kingdom', 'Grenada', 'Georgia', 'French Guiana', 'Guernsey', 'Ghana', 'Gibraltar', 'Greenland', 'Gambia', 'Guinea', 'Guadeloupe', 'Equatorial Guinea', 'Greece', 'South Georgia & South Sandwich Islands', 'Guatemala', 'Guam', 'Guinea-Bissau', 'Guyana', 'Hong Kong SAR China', 'Heard & McDonald Islands', 'Honduras', 'Croatia', 'Haiti', 'Hungary', 'Canary Islands', 'Indonesia', 'Ireland', 'Israel', 'Isle of Man', 'India', 'British Indian Ocean Territory', 'Iraq', 'Iran', 'Iceland', 'Italy', 'Jersey', 'Jamaica', 'Jordan', 'Japan', 'Kenya', 'Kyrgyzstan', 'Cambodia', 'Kiribati', 'Comoros', 'St. Kitts & Nevis', 'North Korea', 'South Korea', 'Kuwait', 'Cayman Islands', 'Kazakhstan', 'Laos', 'Lebanon', 'St. Lucia', 'Liechtenstein', 'Sri Lanka', 'Liberia', 'Lesotho', 'Lithuania', 'Luxembourg', 'Latvia', 'Libya', 'Morocco', 'Monaco', 'Moldova', 'Montenegro', 'St. Martin', 'Madagascar', 'Marshall Islands', 'North Macedonia', 'Mali', 'Myanmar (Burma)', 'Mongolia', 'Macau Sar China', 'Northern Mariana Islands', 'Martinique', 'Mauritania', 'Montserrat', 'Malta', 'Mauritius', 'Maldives', 'Malawi', 'Mexico', 'Malaysia', 'Mozambique', 'Namibia', 'New Caledonia', 'Niger', 'Norfolk Island', 'Nigeria', 'Nicaragua', 'Netherlands', 'Norway', 'Nepal', 'Nauru', 'Niue', 'New Zealand', 'Oman', 'Panama', 'Peru', 'French Polynesia', 'Papua New Guinea', 'Philippines', 'Pakistan', 'Poland', 'St. Pierre & Miquelon', 'Pitcairn Islands', 'Puerto Rico', 'Palestinian Territories', 'Portugal', 'Palau', 'Paraguay', 'Qatar', 'Réunion', 'Romania', 'Serbia', 'Russia', 'Rwanda', 'Saudi Arabia', 'Solomon Islands', 'Seychelles', 'Sudan', 'Sweden', 'Singapore', 'St. Helena', 'Slovenia', 'Svalbard & Jan Mayen', 'Slovakia', 'Sierra Leone', 'San Marino', 'Senegal', 'Somalia', 'Suriname', 'South Sudan', 'São Tomé & Príncipe', 'El Salvador', 'Sint Maarten', 'Syria', 'Swaziland', 'Tristan Da Cunha', 'Turks & Caicos Islands', 'Chad', 'French Southern Territories', 'Togo', 'Thailand', 'Tajikistan', 'Tokelau', 'Timor-Leste', 'Turkmenistan', 'Tunisia', 'Tonga', 'Turkey', 'Trinidad & Tobago', 'Tuvalu', 'Taiwan', 'Tanzania', 'Ukraine', 'Uganda', 'United States', 'Uruguay', 'Uzbekistan', 'Vatican City', 'St. Vincent & Grenadines', 'Venezuela', 'British Virgin Islands', 'U.S. Virgin Islands', 'Vietnam', 'Vanuatu', 'Wallis & Futuna', 'Samoa', 'Kosovo', 'Yemen', 'Mayotte', 'South Africa', 'Zambia', 'Zimbabwe'];
  final List<String> _codes = ['AD', 'AE', 'AF', 'AG', 'AI', 'AL', 'AM', 'AO', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AW', '-', 'AZ', 'BA', 'BB', 'BD', 'BE', 'BF', 'BG', 'BH', 'BI', 'BJ', 'BL', 'BM', 'BN', 'BO', 'NL', 'BR', 'BS', 'BT', '-', 'BW', 'BY', 'BZ', 'CA', 'AU', 'CD', 'CF', 'CG', 'CH', 'CI', 'CK', 'CL', 'CM', 'CN', 'CO', '-', 'CR', 'CU', 'CV', 'CW', 'AU', 'CY', 'CZ', 'DE', '-', 'DJ', 'DK', 'DM', '-', 'DZ', '-', 'EC', 'EE', 'EG', 'MA', 'ER', 'ES', 'ET', '-', 'FI', 'FJ', 'FK', 'FM', 'FO', 'FR', 'GA', 'GB', 'GD', 'GE', '-', 'GG', 'GH', 'GI', 'GL', 'GM', 'GN', '-', 'GQ', 'GR', '-', 'GT', 'GU', 'GW', 'GY', 'HK', '-', 'HN', 'HR', 'HT', 'HU', '-', 'ID', 'IE', 'IL', 'IM', 'IN', 'IO', 'IQ', 'IR', 'IS', 'IT', 'JE', 'JM', 'JO', 'JP', 'KE', 'KG', 'KH', 'KI', 'KM', 'KN', 'KP', 'KR', 'KW', 'KY', 'KZ', 'LA', 'LB', 'LC', 'LI', 'LK', 'LR', 'LS', 'LT', 'LU', 'LV', 'LY', 'MA', 'MC', 'MD', 'ME', 'BL', 'MG', 'MH', 'MK', 'ML', 'MM', 'MN', 'MO', 'MP', '-', 'MR', 'MS', 'MT', 'MU', 'MV', 'MW', 'MX', 'MY', 'MZ', 'NA', 'NC', 'NE', '-', 'NG', 'NI', 'CW', 'NO', 'NP', 'NR', 'NU', 'NZ', 'OM', 'PA', 'PE', 'PF', 'PG', 'PH', 'PK', 'PL', 'PM', 'NZ', '-', 'PS', 'PT', 'PW', 'PY', 'QA', 'YT', 'RO', 'RS', 'KZ', 'RW', 'SA', 'SB', 'SC', 'SD', 'SE', 'SG', 'SH', 'SI', 'NO', 'SK', 'SL', 'SM', 'SN', 'SO', 'SR', 'SS', 'ST', 'SV', 'SX', 'SY', 'SZ', '-', 'TC', 'TD', '-', 'TG', 'TH', 'TJ', 'TK', 'TL', 'TM', 'TN', 'TO', 'TR', 'TT', 'TV', 'TW', 'TZ', 'UA', 'UG', 'CA', 'UY', 'UZ', 'VA', 'VC', 'VE', 'VG', 'VI', 'VN', 'VU', 'WF', 'WS', 'XK', 'YE', 'YT', 'ZA', 'ZM', 'ZW',];

  Countries() {
    countries = [];
    for (int i = 0; i < _names.length; ++i) {
      countries.add(
        Country(dial: _dials[i], flag: _flags[i], name: _names[i], code: _codes[i])
      );
    }
  }

  List<Country> get list => countries;

  Country getBy({
    @required CountryField field,
    @required String value,
  }) {
    return countries.firstWhere((country) => country.getField(field) == value);
  }
}

typedef _SearchOnCloseCallback(Country country);

class CountrySearch extends SearchDelegate<Country> {

  CountrySearch({
    @required this.onClose,
    @required this.countries,
  });

  final Countries countries;
  final _SearchOnCloseCallback onClose;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed:() {} ,)];
  }

  @override
  void close(BuildContext context, Country country) {
    onClose(country);
    super.close(context, country);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context)  => null;

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty 
    ? countries.list 
    : countries.list.where((country) => country.name.toLowerCase().startsWith(query.toLowerCase())).toList();
    
    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return InkWell(
          child: ListTile(
            onTap: () => close(context, suggestions[index]),
            leading: Text(
              suggestion.flag,
              style: TextStyle(fontSize: 23),
            ),
            title: RichText(
              text: TextSpan(
                text: suggestion.name.substring(0, query.length),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    style: TextStyle(color: Colors.black54),
                    text: suggestion.name.substring(query.length)
                  )
                ],
              )
            ),
            trailing: Text(
              '+${suggestion.dial}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Country _country;
  final _countries = Countries();
  final _countryCodeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _country = _countries.getBy(field: CountryField.CODE, value: 'KE');
    _countryCodeTextController.text = _country.dial;
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

    setState(() {
      _country = _countries.getBy(
        field: CountryField.CODE,
        value: countryCode,
      );
    });
  }

  void _onSearchCountryDelegateClosed(Country country) {
    if (country != null) {
      setState(() {
        _country = country;
        _countryCodeTextController.text = _country.dial;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Verify your phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff075e54),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text(
                  'WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number.'
                  'Enter your country code and phone number:'
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showSearch(
                                  context: context, 
                                  delegate: CountrySearch(
                                    countries: _countries,
                                    onClose: _onSearchCountryDelegateClosed,
                                  )
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                  )
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        _country.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Icon(Icons.arrow_drop_down, color: Colors.grey,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextField(
                              autofocus: true,
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
                child: Text(
                  'NEXT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home())
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
