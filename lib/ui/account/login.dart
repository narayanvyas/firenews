import 'package:firenews/ui/global.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _forgotPasswordEmailController =
      TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();

  bool isLoginUi = true, isForgotPasswordUi = false;
  bool isAutoValidateLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login Now'),
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
            child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            isForgotPasswordUi ? Container() : getButtons(),
            isLoginUi
                ? isForgotPasswordUi ? getForgotPasswordUi() : getLoginUi()
                : getSignupUi()
          ],
        )),
      ),
    );
  }

  Widget getButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLoginUi = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: isLoginUi ? Colors.red : Colors.white,
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: isLoginUi ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLoginUi = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: !isLoginUi ? Colors.red : Colors.white,
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        color: !isLoginUi ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getForgotPasswordUi() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TextFormField(
            controller: _forgotPasswordEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Email Address',
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
        RaisedButton(
            color: Colors.deepPurple[900],
            child: Text(
              'Reset Password',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (!regex.hasMatch(_forgotPasswordEmailController.text))
                displaySnackBar('Email Id Is Wrong', _scaffoldKey);
              else {
                displaySnackBar('Password Resetted Successfully', _scaffoldKey);
              }
            }),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: InkWell(
              onTap: () {
                setState(() {
                  isForgotPasswordUi = false;
                });
              },
              child: Text('Login Now')),
        )
      ],
    );
  }

  Widget getLoginUi() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autovalidate: isAutoValidateLogin,
              validator: (value) {
                if (!regex.hasMatch(value))
                  return "Please Enter Valid Email Address";
                else
                  return null;
              },
              decoration: InputDecoration(
                  hintText: 'Email Address',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextFormField(
              controller: _passwordController,
              autovalidate: isAutoValidateLogin,
              validator: (value) {
                if (value.length < 8)
                  return "Please Enter Valid Password";
                else
                  return null;
              },
              decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          RaisedButton(
              color: Colors.deepPurple[900],
              child: Text(
                'Login Now',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_loginFormKey.currentState.validate()) {
                  print('Logged In Successfully');
                  setState(() {
                    isAutoValidateLogin = false;
                  });
                } else
                  setState(() {
                    isAutoValidateLogin = true;
                  });
              }),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    isForgotPasswordUi = true;
                  });
                },
                child: Text('Forgot Password?')),
          )
        ],
      ),
    );
  }

  dynamic getSignupUi() {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * 0.25,
          color: Colors.red,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TextFormField(
            controller: _signupEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Email Address',
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TextFormField(
            controller: _signupPasswordController,
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
        RaisedButton(
            color: Colors.deepPurple[900],
            child: Text(
              'Signup Now',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (!regex.hasMatch(_emailController.text))
                displaySnackBar('Email Id Is Wrong', _scaffoldKey);
              else if (_passwordController.text.length < 8)
                displaySnackBar(
                    'Password Length Must Be Of Minimum 8 Characters',
                    _scaffoldKey);
              else {
                displaySnackBar('Logged In Successfully', _scaffoldKey);
              }
            })
      ],
    );
  }
}
