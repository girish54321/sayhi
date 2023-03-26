import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sayhi/widget/app_button.dart';
import 'package:sayhi/widget/hi_emoji.dart';
import 'package:sayhi/widget/phone_input.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  late TextEditingController telegramController;
  late TextEditingController emailontroller;
  String initialCountry = 'IN';
  String code = "+91";
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  void _launchURL(String url) async {
    if (!await launch(url, forceSafariVC: false, forceWebView: false))
      // ignore: curly_braces_in_flow_control_structures
      throw 'Could not launch $url';
  }

  @override
  void initState() {
    telegramController = TextEditingController();
    emailontroller = TextEditingController();
    super.initState();
  }

  void setCode(PhoneNumber number) {
    setState(() {
      code = (number.dialCode ?? "+91");
    });
  }

  Widget whatsAppbutton() {
    return AppButton(
      function: () {
        formKey.currentState!.save();
        if (formKey.currentState!.validate()) {
          String _url = 'https://wa.me/${code + controller.text}?text=Hii%20';
          _launchURL(_url);
        }
      },
      icon: const Icon(FontAwesomeIcons.whatsapp),
      label: 'Say Hi form Whats App',
    );
  }

  Widget signalButton() {
    return const AppButton(
      function: null,
      icon: null,
      label: 'Say Hi from Signal',
    );
  }

  Widget telegramButton() {
    return AppButton(
      function: () async {
        final userName = await showDialog(
            context: context,
            builder: (context) {
              final _formTelegram = GlobalKey<FormState>();
              return AlertDialog(
                title: const Text("Enter Telegram username"),
                content: Form(
                  key: _formTelegram,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Telegram username';
                      }
                      return null;
                    },
                    controller: telegramController,
                    autofocus: true,
                    decoration: const InputDecoration(hintText: "Username"),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (_formTelegram.currentState!.validate()) {
                          Navigator.of(context).pop(telegramController.text);
                        }
                      },
                      child: const Text("Say Hi"))
                ],
              );
            });
        if (userName == null || userName.isEmpty) return;
        String url = 'https://telegram.me/${userName}';
        telegramController.text = "";
        _launchURL(url);
      },
      icon: const Icon(FontAwesomeIcons.telegram),
      label: 'Say Hi from Telegram',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Say Hii"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const HiEmoji(),
                  Form(
                    key: formKey,
                    child: PhoneInput(
                      number: number,
                      setCode: setCode,
                      textEditingController: controller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Wrap(
                      spacing: 16,
                      children: [
                        whatsAppbutton(),
                        signalButton(),
                        telegramButton()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    telegramController.dispose();
    super.dispose();
  }
}
