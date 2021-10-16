import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

//comment 1 : make this screen as StatefulWidget because change the states here
class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit_screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //comment 10 : create a new variable _imageUrlController for get image url that user placed
  final _imageUrlController = TextEditingController();
  //comment 7 : use FocusNode for chnage between fields when tap on next button on keyboard in v2.5.1 flutter , flutter do this automatically
  // comment 8 : here i use FocusNode for my image that when enter on other Fields update my image place that is an any image or not
  final _imageUrlFocusNode = FocusNode();
  //comment 3 : then for I can access to my for data like : access to sve form , access to validate myform ,...
  // have to define a variable like _form =GlobalKey<FormState> to make a key for access to form
  final _form = GlobalKey<FormState>();
//comment 15 : it time to add new product to the list of products
// call Product and put all objects as empty and save them in _editProduct
  var _editProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  //comment 25 : create new variable _initValue for storage current values of product we want to edit it
  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
//comment 22 : create a new variable _isInstate for update data
  var _isInstate = true;
  @override
  //comment 11 : use initState() for update image preview please in time
  //comment 13 : after create _updateImageUrl call it for addListener as argument
  //addListener is for show an object if it changed in time
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  //comment 14 : dispose() is for destroy the useless data this trash data created when you type some test or paste image url to its field and tap on back button to
  // back to previous screen its make trash data and make app slower dispose() delete these data
  void dispose() {
    _imageUrlController.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    // _priceFocusNode.dispose();
    // _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

// comment 12 : define a function like  _updateImageUrl for say if textField that is for image url if it hasn't any focuse reference set that state as empty state
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override

/////////////  all behaviors in didChangeDependencies is for previous data not current data (previous product that was created and now we just want to edit them)   //////////

  //comment 21 : its time to  work on edit each item use didChangeDependencies : its simple mean is change on products that created and stored time ago
  void didChangeDependencies() {
    //comment 23 : here use _isInstate if it was true (if was any product for edit):
    if (_isInstate) {
      //then find that product in Products Most important part of course (learn add new product to Products ,edit product, create Formslist by id
      // get that id from UserProductsScreen
      // if that product hasn't any id and it was ==null return "NULL"
      //else return that id and save it at productId
      final productId = ModalRoute.of(context)!.settings.arguments == null
          ? "NULL"
          : ModalRoute.of(context)!.settings.arguments as String;
      //comment 24 : now if there was any id and productId was not "NULL"
      if (productId != "NULL") {
        //comment 26 : now we have id time to find our Product by that id in list of products
        _editProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        //comment 27 : now its time to save current product values as default fields data
        _initValue = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          //comment 30 : here put imageUrl as Empty string
          'imageUrl': '',
        };
        //and set imageUrl value here to _imageUrlController.text= _editProduct.imageUrl
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    // at last put _isInstate as false its mean end of update statement for previous products
    _isInstate = false;
    super.didChangeDependencies();
  }

// comment 5 : define a function for save FormFields data use this function at appBar IconButton and done button in keyboard for last field
  void _saveForm() {
    //comment 20 : to see impact of validate of form fields use  _form.currentState!.validate() for if any field has incorrect value don't save form
    final isSave = _form.currentState!.validate();
    if (!isSave) {
      return;
    }
//comment 6 :the command for save form is _form.currentState!.save()
//comment 17 : aftter create onSave for all Fields call _form key and .currentState!.save() to stroage curret values of fields to Form
    _form.currentState!.save();
/////       update Product or create new one     /////

    //comment 28 : time to  say to app is it new product or update of previous product
    // create an if statement and say if product has  a id its mean we want to update product
    if (_editProduct.id != '') {
      //so call updateProduct() function that make it
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
      // oderwise we need to create a new product
      // so call addProducts() function
    } else {
      Provider.of<Products>(context, listen: false).addProducts(_editProduct);
    }
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
        title: Text('Edit Product'),
      ),
      //comment 2 : first create a Form for my text fields of title, price, ...
      body: Form(
        //comment 4 : and here i use _form as my Form key to get access out of build widget
        key: _form,
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                //comment 16 : for save data that get from textFields use onSaved property for save data to _editProduct
                //do this work for all textFields According to their name
                onSaved: (value) {
                  _editProduct = Product(
                      id: _editProduct.id,
                      title: value as String,
                      description: _editProduct.description,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                },
                //comment 19 : validator is an other property of TextFormField for validate inputs of each field
                // like : is it Empty or not , is it an url for imageUrl field or not, is it a number for price or not ,...
                // how to define validator is at below lines
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValue['price'],
                validator: (value) {
                  if (double.tryParse(value!) == null) {
                    return 'Please Enter a valid number';
                  }
                  if (value.isEmpty) {
                    return 'Please Enter a number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number more than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      id: _editProduct.id,
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editProduct.imageUrl,
                      isFavorite: _editProduct.isFavorite);
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'price'),
              ),
              TextFormField(
                initialValue: _initValue['description'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please complate fields';
                  }
                  if (value.length < 10) {
                    return 'please enter characters more than 10';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      id: _editProduct.id,
                      isFavorite: _editProduct.isFavorite,
                      title: _editProduct.title,
                      description: value as String,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                },
                keyboardType: TextInputType.multiline,
                maxLines: 3,

                decoration: InputDecoration(labelText: 'description'),
                // focusNode: _descriptionFocusNode,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 8),
                    width: 100,
                    height: 100,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Its Empty')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                          ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter an URL Image';
                        }
                        if (!value.startsWith('http') &&
                            (!value.startsWith('https'))) {
                          return 'Please Enter a correct URL Image';
                        }
                        if (!value.endsWith('.jpg') &&
                            !value.endsWith('.png') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a correct Image with suffix (.jpg ,.png,.jpeg)';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editProduct = Product(
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                            title: _editProduct.title,
                            description: _editProduct.description,
                            price: _editProduct.price,
                            imageUrl: value as String);
                      },
                      //comment 29 : because we define controller cant use validator together
                      // and for command to show current product image go to comment 30 in _initValue
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      maxLines: 3,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: 'Enter Url'),
                      //comment 9 :TextFormField has a property its focusNode it give focuses like _imageUrlFocusNode that i created
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      //comment 18 : onEditingComplete is for last field its means its last field and editing is complete
                      onEditingComplete: () => setState(() {}),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
