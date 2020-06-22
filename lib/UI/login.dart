import 'package:testcart/UI/main_screen.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/Utils/service.dart';
import 'package:testcart/ViewModel/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  bool _isInvisible = true;
  String _username = '';
  String _password = '';
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    Data.buildContext = context;
    final screen = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return ChangeNotifierProvider<LoginNotifier>(
        create: (_) => service<LoginNotifier>(),
        child: Scaffold(
          body: Form(
            key: _formState,
            child: Container(
              height: screen.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screen.height * 0.25,
                    ),
                    Image.asset(
                      "icon/icon.png",
                      height: screen.height * 0.15,
                    ),
                    SizedBox(
                      height: screen.height * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty)
                            return 'Enter username';
                          else if (value.length < 4)
                            return 'Username must be at least 4 words in length';
                          return null;
                        },
                        onChanged: (String value) => _username = value,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            hintText: " Username",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Icon(
                                Icons.email,
                                color: theme.accentColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 13)),
                      ),
                    ),
                    SizedBox(
                      height: screen.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        maxLines: 1,
                        obscureText: _isInvisible,
                        validator: (value) {
                          if (value.isEmpty) return "Enter password";
                          return null;
                        },
                        onChanged: (String value) => _password = value,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isInvisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: theme.accentColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isInvisible = !_isInvisible;
                                });
                              },
                            ),
                            hintText: " Password",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Icon(
                                Icons.lock,
                                color: theme.accentColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).accentColor)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12)),
                      ),
                    ),
                    SizedBox(
                      height: screen.height * 0.05,
                    ),
                    Consumer<LoginNotifier>(builder: (context, model, child) {
                      if (model.isSignedIn) _go(context);
                      return InkWell(
                        splashColor: theme.accentColor,
                        borderRadius: BorderRadius.circular(
                            (model.state == RequestState.Busy) ? 50 : 5),
                        child: AnimatedContainer(
                            decoration: BoxDecoration(
                                color: theme.accentColor,
                                borderRadius: BorderRadius.circular(
                                    (model.state == RequestState.Busy)
                                        ? 50
                                        : 5),
                                border: Border.all(
                                    color: Colors.amberAccent, width: 1.4)),
                            width: model.state == RequestState.Busy
                                ? screen.width * 0.1
                                : 130,
                            height: screen.width * 0.1,
                            duration: Duration(milliseconds: 200),
                            child: Center(
                              child: getLoginButtonStatus(
                                  model.state, theme.accentColor),
                            )),
                        onTap: () {
                          final userCreds = {
                            'username': _username,
                            'password': _password
                          };
                          if (_formState.currentState.validate()) {
                            model.login(userCreds);
                          }
                        },
                      );
                    }),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget getLoginButtonStatus(RequestState state, Color color) {
    if (state == RequestState.Busy)
      return Padding(
        padding: const EdgeInsets.all(1),
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    else if (state == RequestState.Done)
      return Icon(
        Icons.check,
        color: Colors.white,
      );
    else
      return Text(
        "Login",
        style: TextStyle(
            fontFamily: fFamily,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16),
      );
  }

  void _go(context) async {
    await Future.delayed(Duration(milliseconds: 400));
    Navigator.of(context).pushAndRemoveUntil(
        Data.routeSwitcher(context, MainScreen()), (route) => false);
  }
}
