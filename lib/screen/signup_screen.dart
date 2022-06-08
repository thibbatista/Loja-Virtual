import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_flutter/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController(); // nome
  final _emailController = TextEditingController(); //email
  final _passController = TextEditingController();//senha
  final _addressController = TextEditingController();//endereço
  final _scaffoldKey = GlobalKey<ScaffoldState>();//para ter ascesso ao scaffold



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Criar Conta",
          ),
          centerTitle: true,

        ),
        body:ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              if (model.isLoading)
                return Center(child: CircularProgressIndicator(),);
              return  Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Nome Completo"),


                     validator: (text){


                        if(text.isEmpty ) return "Nome inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "e-mail"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text){


                        if(text.isEmpty || !text.contains("@")) return "e-mail inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text){


                        if(text.isEmpty || text.length < 6) return "senha inválida";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(hintText: "Endereço"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text){


                        if(text.isEmpty) return "Endereço inválido";
                      },
                    ),

                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(

                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),


                        child: Text("Criar Conta",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: (){
                          if(_formKey.currentState.validate()){

                            Map<String , dynamic> userData ={
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _addressController.text,
                            };
                            model.signUP(
                                userData: userData ,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                            );

                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            }

        )
    );
  }

  void _onSuccess(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ),


    );
    Future.delayed((Duration(seconds: 2))).then((_){
      Navigator.of(context).pop();
    });




  }

  void _onFail(){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ),

    );

  }
}
