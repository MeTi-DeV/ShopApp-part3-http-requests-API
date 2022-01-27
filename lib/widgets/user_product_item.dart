import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;
  UserProductItem(this.title, this.imageUrl, this.id);
  @override
  Widget build(BuildContext context) {
    //comment 1 : because we can't use of(context) here define it as scaffold variabl
    final scaffold=Scaffold.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl.toString()),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id),
                icon: Icon(Icons.edit),
              ),
              IconButton(
                //comment 1 : here I want to show error connection to my user as SnackBar
                onPressed: () async{
                  try {
                 await   Provider.of<Products>(context, listen: false)
                        .removeProduct(id);
                  } catch (error) {
                    
scaffold.showSnackBar(SnackBar(content: Text('Remove Product was Faild')));
                  }
                  ;
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
