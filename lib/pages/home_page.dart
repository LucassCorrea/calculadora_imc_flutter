import 'package:calculadora_imc_flutter/models/imc_model.dart';
import 'package:calculadora_imc_flutter/repository/imc_repository.dart';
import 'package:calculadora_imc_flutter/utils/utils.dart';
import 'package:calculadora_imc_flutter/validators/form_validator.dart';
import 'package:calculadora_imc_flutter/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var _pesoController = TextEditingController(text: "");
var _alturaController = TextEditingController(text: "");
var _listIMC = <IMCModel>[];
var _imcRepository = IMCRepository();

double _peso = 0.0;
double _altura = 0.0;
dynamic _pesoError;
dynamic _alturaError;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    _listIMC = await _imcRepository.get();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pesoController.text = "";
          _alturaController.text = "";
          _altura = 0;
          _peso = 0;

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Calcular IMC"),
              content: StatefulBuilder(
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
                        errorText: _pesoError,
                        onChanged: (_) => setState(() {
                          _pesoError = FormValidator.errorText(_pesoController);
                          if (_pesoError == null) {
                            _peso = Utils.toDouble(_pesoController);
                          }
                        }),
                      ),
                    ),
                    TextFieldWidget(
                      text: "Altura (cm)",
                      controller: _alturaController,
                      errorText: _alturaError,
                      onChanged: (_) => setState(() {
                        _alturaError =
                            FormValidator.errorText(_alturaController);
                        if (_alturaError == null) {
                          _altura = Utils.toDouble(_alturaController);
                        }
                      }),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    if (_altura > 0 && _peso > 0) {
                      double imc = IMCRepository.calcularIMC(
                        _peso,
                        _altura,
                      );

                      await _imcRepository.add(
                        IMCModel(
                          _altura,
                          _peso,
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
                        await _imcRepository.remove(e.id);
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
                          DateFormat("dd/MM/yyyy").format(e.data),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () async {
                          await _dialogInfo(e);
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

  Future _dialogInfo(IMCModel model) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          children: [
            Column(
              children: [
                Container(
                  height: 8,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const Text(
                  "Detalhes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    DateFormat("dd/MM/yyyy").format(model.data),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Altura: ${model.altura} cm",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Peso: ${model.peso} kg",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "Classificação: ${model.classificacao}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
