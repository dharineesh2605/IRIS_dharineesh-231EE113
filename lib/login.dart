import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/login/login_events.dart';
import 'bloc/login/login_state.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginUserSuccess) {
              Navigator.pushReplacementNamed(context, "/userhome");
            } else if (state is LoginAdminSuccess) {
              Navigator.pushReplacementNamed(context, "/adminhome");
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Failed: ${state.error}')),
              );
            } else if (state is SignupRedirect) {
              Navigator.pushReplacementNamed(context, "/signup");
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: password,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: role,
                      decoration: const InputDecoration(
                        hintText: "user/admin",
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (email.text.isNotEmpty && password.text.isNotEmpty) {
                          context.read<LoginBloc>().add(
                                LoginSubmitted(
                                    email.text, password.text, role.text),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Please enter email and password')),
                          );
                        }
                      },
                      child: state is LoginLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Signin"),
                    ),
                    const SizedBox(height: 10),
                    const Text("If not a user"),
                    GestureDetector(
                      onTap: () {
                        context.read<LoginBloc>().add(SignupClicked());
                      },
                      child: const Text(
                        "Signup",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController role = TextEditingController();

void clearLoginTextfields() {
  email.clear();
  password.clear();
  role.clear();
}
