import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shop/providers/models/product.dart';
import 'package:simple_shop/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _initialized = false;

  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    // 'imageURL': '',
  };
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener((_imageUpdater));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      final id = ModalRoute.of(context)!.settings.arguments as String?;
      if (id != null) {
        _editedProduct = Provider.of<Products>(context).findById(id);
        _initValues['title'] = _editedProduct.title;
        _initValues['price'] = _editedProduct.price.toString();
        _initValues['description'] = _editedProduct.description;
        // _initValues['imageURL'] = _editedProduct.imageUrl;
        _imageUrlController.text = _editedProduct.imageUrl;
      }
      _initialized = true;
    }
    super.didChangeDependencies();
  }

  void _imageUpdater() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.startsWith('http') &&
              _imageUrlController.text.startsWith('https') ||
          _imageUrlController.text.endsWith('.png') &&
              _imageUrlController.text.endsWith('.jpg') &&
              _imageUrlController.text.endsWith('.jpeg')) return null;
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _formKey.currentState!.validate();
    if (!_isValid) return;

    _formKey.currentState!.save();
    if (_editedProduct.id == '')
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    else
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pleas provide a title';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: newValue!,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pleas provide a price';
                  }
                  if (double.tryParse(value) == null)
                    return 'please enter a valid number';
                  if (double.parse(value) <= 0)
                    return 'please enter a numbet greater than 0';
                  return null;
                },
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(newValue!),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pleas provide a description';
                  }
                  if (value.length < 10)
                    return 'description must be at least 10 characters';
                  return null;
                },
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: newValue!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                //  onFieldSubmitted: (value) =>
                //     FocusScope.of(context).requestFocus(_priceFocusNode),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 20),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter Url')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text)),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pleas provide a URL';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https'))
                          return 'plaese provide a valid URL';
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg'))
                          return 'please enter an image URL';
                        return null;
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: newValue!,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
