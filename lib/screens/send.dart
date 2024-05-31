import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiprova_wallet/enums/currency.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/container_icon.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/modal.dart';
import 'package:multiprova_wallet/widgets/snackbar.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  Currency currencySelected = Currency.multiprovaCoin;
  final _valueController = TextEditingController(text: '0');
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currencySelectedName = currencySelected.name;

    return Display(
      title: Text('Enviar', style: Theme.of(context).textTheme.titleLarge),
      body: Column(
        children: <Widget>[
          CardOutlined(
            body: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ContainerIcon(padding: 8.0, icon: Icons.paid),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(currencySelectedName, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    MenuAnchor(
                      builder: (BuildContext context, MenuController controller, Widget? child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          tooltip: 'Selecionar moeda',
                        );
                      },
                      menuChildren: List<MenuItemButton>.generate(
                        2,
                        (int index) => MenuItemButton(
                          onPressed: () => setState(() => currencySelected = Currency.values[index]),
                          child: Text(Currency.values[index].name),
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _valueController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 8.0, top: 0.0),
                        ),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: ContainerIcon(padding: 8.0, icon: Icons.link_rounded),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Endereço',
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            contentPadding: EdgeInsets.only(bottom: 8.0, top: 0),
                          ),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            width: double.maxFinite,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button(
                  label: 'Enviar',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.send_rounded, color: white, size: 16.0),
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Modal(
                      title: 'Deseja continuar?',
                      textBody:
                          'Deseja enviar ${_valueController.text} $currencySelectedName para o endereço digitado? Confira as informações antes de enviar.',
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(Snackbar(text: 'Envio realizado com sucesso').build(context));
                            Navigator.pop(context);
                          },
                          child: Text('Enviar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 64.0, bottom: 16.0),
            child: SvgPicture.asset(
              "assets/illustration_send.svg",
              height: 191.91,
              width: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Certifique-se de que o endereço inserido é um endereço válido para não correr o risco de perder seus tokens. O Multiprova não se responsabiliza por tokens perdidos.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      screenActive: NavigationBarActions.none,
      automaticallyImplyLeading: true,
    );
  }
}
