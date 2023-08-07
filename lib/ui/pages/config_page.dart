import 'package:calculadora_imc_flutter/core/repository/shared_repository.dart';
import 'package:calculadora_imc_flutter/core/utils/utils.dart';
import 'package:calculadora_imc_flutter/core/validators/form_validator.dart';
import 'package:calculadora_imc_flutter/ui/widgets/custom_drawer_widget.dart';
import 'package:calculadora_imc_flutter/ui/widgets/messenger_snackbar_widget.dart';
import 'package:calculadora_imc_flutter/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

SharedRepository storage = SharedRepository();

class _ConfigPageState extends State<ConfigPage> {
  final _alturaController = TextEditingController(text: "");
  bool isAlturaFixa = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    isAlturaFixa = await storage.getIsFixedAltura();
    if (isAlturaFixa == false) {
      _alturaController.text = "";
    } else {
      _alturaController.text = (await storage.getAltura()).toString();
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _alturaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      drawer: const CustomDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SwitchListTile(
              title: const Text("Altura fixa"),
              value: isAlturaFixa,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              onChanged: (value) async {
                setState(() {
                  isAlturaFixa = value;
                });
              },
            ),
            Visibility(
              visible: isAlturaFixa,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFieldWidget(
                  text: "Altura (cm)",
                  controller: _alturaController,
                  onlyNumber: true,
                  validator: (text) => FormValidator.errorText(text!),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  if (isAlturaFixa == false) {
                    await storage.setIsFixedAltura(isAlturaFixa);
                    _alturaController.text = "";

                    if (context.mounted) {
                      MessengerSnackBar.mensseger(
                        context,
                        "Altura fixa desabilitada.",
                      );
                    }
                  } else if (isAlturaFixa == true &&
                      _formKey.currentState!.validate()) {
                    await storage
                        .setAltura(Utils.toDouble(_alturaController.text));
                    await storage.setIsFixedAltura(isAlturaFixa);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Dados salvos com sucesso!"),
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      MessengerSnackBar.mensseger(
                        context,
                        "Verifique os campos e tente novamente",
                      );
                    }
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Erro ao salvar os dados.\nPor favor, tente novamente...",
                      ),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
