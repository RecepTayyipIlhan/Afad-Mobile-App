import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/screens/login.dart';
import 'dart:math';

Random random = Random();
int randomNumber = random.nextInt(100);

class SignupPage extends StatefulWidget {
  const SignupPage({
    super.key,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameC = TextEditingController();

  TextEditingController surnameC = TextEditingController();

  TextEditingController emailC = TextEditingController();

  TextEditingController phoneC = TextEditingController();

  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordConfirmC = TextEditingController();

  void showError({
    required String errorTitle,
    required String errorMessage,
  }) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: errorTitle,
        message: errorMessage,
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /*CollectionReference<Object?> firestore_test(){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users_ref = FirebaseFirestore.instance.collection('user');
    return users_ref;
  }*/
  void signup({
    required String username,
    required String surname,
    required String password,
    required String passwordConfirm,
    required String email,
    required String phone,
  }) async {
    if (username.isEmpty) {
      showError(
        errorTitle: "İsim Boş Bırakılamaz",
        errorMessage: "Lütfen isminizi giriniz",
      );
      return;
    }

    if (surname.isEmpty) {
      showError(
        errorTitle: "Soyisim Boş Bırakılamaz",
        errorMessage: "Lütfen soyisminizi giriniz",
      );
      return;
    }

    if (email.isEmpty) {
      showError(
        errorTitle: "Email Boş Bırakılamaz",
        errorMessage: "Lütfen emailinizi giriniz",
      );
      return;
    }

    if (phone.isEmpty) {
      showError(
        errorTitle: "Telefon Numarası Boş Bırakılamaz",
        errorMessage: "Lütfen telefon numaranızı giriniz",
      );
      return;
    }

    if (password.isEmpty) {
      showError(
        errorTitle: "Şifre Boş Bırakılamaz",
        errorMessage: "Lütfen şifrenizi giriniz",
      );
      return;
    }
    if (passwordConfirm.isEmpty) {
      showError(
        errorTitle: "Şifre Tekrarı Boş Bırakılamaz",
        errorMessage: "Lütfen şifre tekrarını giriniz",
      );
      return;
    }

    if (password != passwordConfirm) {
      showError(
        errorTitle: "Şifreler Eşleşmiyor",
        errorMessage: "Lütfen şifreleri kontrol edin",
      );
      return;
    }

    FirebaseFirestore db = FirebaseFirestore.instance;

    Random random = Random();

    int id = random.nextInt(999999) + 100000;
    String idS = id.toString();

    try {
      await db.collection('People').doc(idS).set(
        {
          "id": idS,
          'name': username,
          'surname': surname,
          'phone': phone,
          'password': password,
          'email': email,
          'address': "",
          'people_with': "",
          "blood_group": "",
          "tc_id_number": "",
          "relative_phone": "",
          "diseases": "",
          "medicines": ""
        },
      );
    } catch (e) {
      showError(
        errorTitle: "Kayıt Başarısız",
        errorMessage:
            "Kayıt işlemi başarısız oldu. Lütfen daha sonra tekrar deneyin.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        //reverse: true,
        child: SizedBox(
          //height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    "Kayıt",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Yeni Bir Afet Koordinasyon Uygulaması Hesabı Oluşturun",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Column(
                  children: <Widget>[
                    makeInput(label: "Name", controllerName: nameC),
                    makeInput(
                      label: "Surname",
                      controllerName: surnameC,
                    ),
                    makeInput(label: "Email", controllerName: emailC),
                    makeInput(
                        label: "Telefon Numarası", controllerName: phoneC),
                    makeInput(
                        label: "Şifre",
                        obscureText: true,
                        controllerName: passwordC),
                    makeInput(
                        label: "Şifreyi Doğrula",
                        obscureText: true,
                        controllerName: passwordConfirmC),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: MaterialButton(
                    color: Colors.blueAccent.withOpacity(0.8),
                    onPressed: () {
                      print(nameC.text);
                      signup(
                        username: nameC.text,
                        surname: surnameC.text,
                        password: passwordC.text,
                        passwordConfirm: passwordConfirmC.text,
                        email: emailC.text,
                        phone: phoneC.text,
                      );
                    },
                    minWidth: double.infinity,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Kayıt Ol",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Eğer hesabınız varsa giriş yapınız."),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: const Text(
                        "Giriş",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obscureText = false, controllerName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        controller: controllerName,
        obscureText: obscureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
