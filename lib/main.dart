// import 'package:flutter/material.dart';
// import 'package:sayhi/screen/home_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Say Hii"),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  late TextEditingController telegramController;
  String initialCountry = 'IN';
  String code = "+91";
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  void _launchURL(String url) async {
    if (!await launch(url, forceSafariVC: false, forceWebView: false))
      throw 'Could not launch $url';
  }

  @override
  void initState() {
    telegramController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "🙋🏻‍♀️",
                    style: TextStyle(fontSize: 44),
                  ),
                ),
                InternationalPhoneNumberInput(
                  autoFocus: true,
                  hintText: "Say Hii to ..",
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                    setState(() {
                      code = (number.dialCode ?? "+91");
                    });
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: controller,
                  formatInput: false,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: const OutlineInputBorder(),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Wrap(
                    spacing: 16,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            formKey.currentState!.save();
                            print(formKey.currentState!.validate());
                            if (formKey.currentState!.validate()) {
                              print(controller.text);
                              String _url =
                                  'https://wa.me/${code + controller.text}?text=Hii%20';
                              _launchURL(_url);
                            }
                          },
                          // style: ButtonStyle(colo: Colors.amber),
                          icon: const Icon(FontAwesomeIcons.whatsapp),
                          label: const Text('Say Hi form Whats App')),
                      const ElevatedButton(
                        onPressed: null,
                        child: Text('Say Hi from Signal'),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(FontAwesomeIcons.telegram),
                        onPressed: () async {
                          final userName = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter Telegram username"),
                                  content: TextField(
                                    controller: telegramController,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        hintText: "Username"),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(telegramController.text);
                                        },
                                        child: const Text("Hi"))
                                  ],
                                );
                              });
                          if (userName == null || userName.isEmpty) return;
                          String url = 'https://telegram.me/${userName}';
                          telegramController.text = "";
                          _launchURL(url);
                        },
                        label: const Text('Say Hi from Telegram'),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.at,
                    size: 33,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Send Email to ..",
                      prefixIcon: Icon(Icons.mail),
                      suffixIcon: Icon(Icons.close)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        formKey.currentState!.save();
                        print(formKey.currentState!.validate());
                        if (formKey.currentState!.validate()) {
                          print(controller.text);
                          String _url =
                              'https://wa.me/${code + controller.text}?text=Hii%20';
                          _launchURL(_url);
                        }
                      },
                      // style: ButtonStyle(colo: Colors.amber),
                      icon: const Icon(FontAwesomeIcons.whatsapp),
                      label: const Text('Say Hi form Whats App')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    telegramController.dispose();
    super.dispose();
  }
}
