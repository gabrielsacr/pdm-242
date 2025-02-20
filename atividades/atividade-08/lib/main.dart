import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



void main() {
  runApp(const MyApp());
}

// Definição da classe MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormValidationScreen(),
    );
  }
}

class FormValidationScreen extends StatefulWidget {
  const FormValidationScreen({super.key});

  @override
  State<FormValidationScreen> createState() => _FormValidationScreenState();
}

class _FormValidationScreenState extends State<FormValidationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  // Máscaras para formatação
  final _dateFormatter = MaskTextInputFormatter(mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});
  final _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  // Validação da Data (dd-mm-aaaa)
  String? validateDate(String? value) {
    if (value == null || value.isEmpty) return "Campo obrigatório";
    final RegExp regex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    if (!regex.hasMatch(value)) return "Formato inválido (dd-mm-aaaa)";
    try {
      DateFormat('dd-MM-yyyy').parseStrict(value);
      return null;
    } catch (e) {
      return "Data inválida";
    }
  }

  // Validação de Email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Campo obrigatório";
    final RegExp regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return "E-mail inválido";
    return null;
  }

  // Validação de CPF
  String? validateCPF(String? value) {
    if (value == null || value.isEmpty) return "Campo obrigatório";
    if (!_isValidCPF(value)) return "CPF inválido";
    return null;
  }

  // Validação de Valor (número positivo)
  String? validateValue(String? value) {
    if (value == null || value.isEmpty) return "Campo obrigatório";
    final RegExp regex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!regex.hasMatch(value)) return "Valor inválido (ex: 123.45)";
    return null;
  }

  // Função para validar CPF
  bool _isValidCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    if (cpf.length != 11 || RegExp(r'(\d)\1{10}').hasMatch(cpf)) return false;

    List<int> numbers = cpf.split('').map(int.parse).toList();

    for (int i = 9; i < 11; i++) {
      int sum = 0;
      for (int j = 0; j < i; j++) {
        sum += numbers[j] * ((i + 1) - j);
      }
      int digit = (sum * 10) % 11;
      if (digit == 10) digit = 0;
      if (numbers[i] != digit) return false;
    }
    return true;
  }

  // Enviar Formulário
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Formulário enviado com sucesso! 🎉")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Validação de Formulário")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campo Data
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: "Data (dd-mm-aaaa)"),
                  validator: validateDate,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [_dateFormatter],
                ),
                SizedBox(height: 10),

                // Campo Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "E-mail"),
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),

                // Campo CPF
                TextFormField(
                  controller: _cpfController,
                  decoration: InputDecoration(labelText: "CPF"),
                  validator: validateCPF,
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfFormatter],
                ),
                SizedBox(height: 10),

                // Campo Valor
                TextFormField(
                  controller: _valueController,
                  decoration: InputDecoration(labelText: "Valor"),
                  validator: validateValue,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),

                // Botão de Enviar
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Enviar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
