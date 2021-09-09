import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:store_house/controller/create_item_controller.dart';
import 'package:store_house/util/notification_util.dart';

class CreateItem extends StatefulWidget {
  static final String name = '/CREATE_ITEM';

  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final _formKey = GlobalKey<FormBuilderState>();
  final CreateItemController _createItemController = Get.find();
  final inputDecoration = InputDecoration();
  final numberTransformer = (value) =>
      value == null ? '0.00' : double.parse(value).toStringAsFixed(2);
  bool hasBarcode = false;

  void _clearBarcodeField() {
    _formKey.currentState!
        .patchValue({'barcodeId': ''});
    setState(() => hasBarcode = false);
  }

  Future<void> _scanBarCode(BuildContext context) async {
    try {
      final result = await FlutterBarcodeScanner.scanBarcode(
          '#FFE3BE78'.toString(), 'Cancel', true, ScanMode.BARCODE);
      if (result != '-1') {
        setState(() => hasBarcode = true);
        _formKey.currentState!.patchValue({'barcodeId': result});
      }
    } catch (error) {
      showErrorMessage(error);
    }
  }

  Future<void> _createItem(BuildContext context) async {
    try {
      Loader.show(context);
      if (_formKey.currentState!.saveAndValidate()) {
        final data = _formKey.currentState!.value;
        await _createItemController.createItem(data);
        setState(() => hasBarcode = false);
        _formKey.currentState!.reset();
        _formKey.currentState!.fields['itemName']!.requestFocus();
      }
    } catch (e) {
      showErrorMessage(e);
    } finally {
      Loader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Item'),
        ),
        body: FormBuilder(
          key: _formKey,
          initialValue: {
            'barcodeId': '',
            'itemName': '',
            'capital': '',
            'wholesale': '',
            'retail': '',
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FormBuilderTextField(
                        name: 'barcodeId',
                        decoration: inputDecoration.copyWith(
                            labelText: 'Item Barcode',
                            suffixIcon: hasBarcode
                                ? IconButton(
                                    onPressed: _clearBarcodeField,
                                    icon: Icon(FontAwesome5.times_circle))
                                : SizedBox()),
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        enableInteractiveSelection: false,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => _scanBarCode(context),
                        child: Text(
                          'Scan Barcode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                FormBuilderTextField(
                  name: 'itemName',
                  decoration: inputDecoration.copyWith(labelText: 'Item Name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'capital',
                  decoration: inputDecoration.copyWith(labelText: 'Capital'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  valueTransformer: numberTransformer,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context)
                  ]),
                ),
                FormBuilderTextField(
                  name: 'wholesale',
                  decoration: inputDecoration.copyWith(labelText: 'Wholesale'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  valueTransformer: numberTransformer,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context)
                  ]),
                ),
                FormBuilderTextField(
                  name: 'retail',
                  decoration: inputDecoration.copyWith(labelText: 'Retail'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  valueTransformer: numberTransformer,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context)
                  ]),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => _createItem(context),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
