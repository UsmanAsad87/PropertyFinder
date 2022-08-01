import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/repository/firestore_methods.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class addProperty extends StatefulWidget {
  const addProperty({Key? key}) : super(key: key);

  @override
  State<addProperty> createState() => _addPropertyState();
}

class _addPropertyState extends State<addProperty> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void createAd() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadAd(
        _titleController.text,
        _typeController.text,
        _priceController.text,
        _areaController.text,
        _cityController.text,
        _descriptionController.text,
        _file!,
      );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Ad Posted!', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void CreateAd() {
    print(_titleController.text);
    print(_typeController.text);
    print(_priceController.text);
    print(_descriptionController.text);
    print(_areaController.text);
    print(_cityController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add The Property'),
      ),
      body: _isLoading?Center(child: const CircularProgressIndicator()):
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            (_file == null)
                ? InkWell(
                    onTap: () async {
                      Uint8List file = await pickImage(ImageSource.gallery);
                      setState(() {
                        _file = file;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blueAccent),
                            image: const DecorationImage(
                                image: AssetImage('assets/uploadImage.png'),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blueAccent),
                          image: DecorationImage(
                              image: MemoryImage(_file!), fit: BoxFit.cover)),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Title',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: TextFormField(
                    controller: _typeController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Residential or Commercial',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Price',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: TextFormField(
                    controller: _areaController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Area(Marla)',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'City',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Description',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  createAd();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>homescreen()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
