import 'package:calculadora_imc_flutter/core/models/imc_model.dart';
import 'package:calculadora_imc_flutter/core/repository/imc_repository.dart';
import 'package:calculadora_imc_flutter/core/utils/utils.dart';
import 'package:calculadora_imc_flutter/core/validators/form_validator.dart';
import 'package:calculadora_imc_flutter/ui/widgets/custom_drawer_widget.dart';
import 'package:calculadora_imc_flutter/ui/widgets/dialogs_widget.dart';
import 'package:calculadora_imc_flutter/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pesoController = TextEditingController(text: "");
  final _alturaController = TextEditingController(text: "");
  var _listIMC = const <IMCModel>[];
  late IMCRepository _imcRepository;
  final _dialogKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    _imcRepository = await IMCRepository.load();
    _listIMC = _imcRepository.get();
    setState(() {});
  }

  accept() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculadora IMC",
        ),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pesoController.text = "";
          _alturaController.text = "";

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Calcular IMC"),
              content: Form(
                key: _dialogKey,
                child: StatefulBuilder(
                  builder: (context, setState) => Wrap(
                    children: [
                      const Text(
                        "Por favor, informe os seguintes dados:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 20),
                        child: TextFieldWidget(
                          text: "Peso (kg)",
                          controller: _pesoController,
                          validator: (text) => FormValidator.errorText(text!),
                        ),
                      ),
                      TextFieldWidget(
                        text: "Altura (cm)",
                        controller: _alturaController,
                        validator: (text) => FormValidator.errorText(text!),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    if (_dialogKey.currentState!.validate()) {
                      var altura = Utils.toDouble(_pesoController.text);
                      var peso = Utils.toDouble(_alturaController.text);

                      double imc = IMCRepository.calcularIMC(
                        Utils.toDouble(_pesoController.text),
                        Utils.toDouble(_alturaController.text),
                      );

                      await _imcRepository.add(
                        IMCModel.criar(
                          altura,
                          peso,
                          imc,
                          IMCRepository.classificacaoIMC(imc),
                        ),
                      );
                      getList();
                      accept();
                    }
                  },
                  child: const Text("Calcular"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _listIMC.isEmpty
          ? const Center(
              child: Text("Nenhum registro foi encontrado"),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: _listIMC.map(
                (e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(e.id),
                      onDismissed: (direction) async {
                        await _imcRepository.remove(e);
                        getList();
                      },
                      resizeDuration: const Duration(milliseconds: 300),
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.grey.shade200,
                        isThreeLine: true,
                        title: Text(
                          e.dataFormatted,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () async {
                          await Dialogs.dialogInfo(context, e);
                        },
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Altura: ${e.altura}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Peso: ${e.peso}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "IMC: ${e.imc}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              e.classificacao,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
    );
  }
}
