import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _product = Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  String? textNotNull(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    } else {
      return null;
    }
  }

  String? validateImageUrl(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    } else if (!(value.endsWith('.jpg') || value.endsWith('.jpeg') || value.endsWith('.png'))) {
      return errorMessage;
    } else {
      return null;
    }
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      final value = _imageUrlController.text;
      final isImageValid = validateImageUrl(value, '_unused') == null;
      if (isImageValid) {
        setState(() {});
      } else {
        print('yo boii image bad');
      }
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      _product = _product.copyWith(id: DateTime.now().toString());
      print('###### TEST ######');
      print(_product.id);
      print(_product.title);
      print(_product.price);
      print(_product.description);
      print(_product.imageUrl);
      print('###### ENDTEST ######');
    }
  }

  @override
  void dispose() {
    // FocusNodes MUST be manually disposed to avoid memory leaks
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Edit Product'), actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                    decoration: const InputDecoration(label: Text('Title')),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocusNode),
                    onSaved: (value) => {_product = _product.copyWith(title: value)},
                    validator: (value) {
                      return textNotNull(value, 'Please provide a title');
                    }),
                TextFormField(
                    decoration: const InputDecoration(label: Text('Price')),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
                    onSaved: (value) => {_product = _product.copyWith(price: double.parse(value ?? '0'))},
                    validator: (value) {
                      const errorMessage = 'Enter a valid price above 0';
                      if (value == null) return errorMessage;

                      final parsedValue = double.tryParse(value);
                      if (parsedValue == null || parsedValue <= 0) return errorMessage;

                      return null;
                    }),
                TextFormField(
                    decoration: const InputDecoration(label: Text('Description')),
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    maxLines: 3,
                    onSaved: (value) => {_product = _product.copyWith(description: value)},
                    validator: (value) {
                      return textNotNull(value, 'Provide a short description');
                    }),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter an URL')
                        : FittedBox(child: Image.network(_imageUrlController.text), fit: BoxFit.contain),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(label: Text('Image URL')),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) => {_product = _product.copyWith(imageUrl: value)},
                      validator: (value) {
                        const errorMessage = 'Provide a valid URL';
                        return validateImageUrl(value, errorMessage);
                      },
                    ),
                  )
                ]),
              ]),
            )),
      ),
    );
  }
}
