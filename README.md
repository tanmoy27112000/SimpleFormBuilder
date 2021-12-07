# Simple Form Builder
[![pub package](https://img.shields.io/pub/v/simple_form_builder.svg)](https://pub.dev/packages/simple_form_builder)
[![GitHub Stars](https://img.shields.io/github/stars/tanmoy27112000/SimpleFormBuilder.svg?logo=github)](https://pub.dev/packages/simple_form_builder)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20IOS%20%7C%20Web-green)](https://img.shields.io/badge/Platform-Android%20%7C%20IOS%20%7C%20Web-green)

A complete form builder for all your needs 

Maintainer : [Tanmoy Karmakar](https://tanmoykarmakar.in)<br>
contributor: [Shayon Sarkar](https://github.com/shayongytworkz)<br>

### Specs
<!-- [![pub](https://img.shields.io/pub/v/flash.svg?style=flat)](https://pub.dev/packages/flash) -->


This library allows you to create a complete form from a json file with
multiple types of fields `text` , `checkbox`, `multiselect` , `datetime` , `date` , `time` , and `file upload`.
This package also provides additional remark options.

It has been written **100% in Dart**. ❤️

<p>
  <img width="205px" alt="Example" src="https://i.imgur.com/vvvcJny.png"/>
  <img width="205px" alt="Example App Closed" src="https://i.imgur.com/5UewKqS.png"/>
  <img width="205px" alt="Example App Open" src="https://i.imgur.com/dNGIkxJ.png" />
</p>


<br>

## Installing
Add the following to your `pubspec.yaml` file:
```yaml
dependencies:
  simple_form_builder: ^0.0.18
```

<br>


<br>

## Simple Usage

To integrate the Simple form builder all you need to do is follow the given JSON schema and pass it to the formBuilder widget

### JSON Schema

```dart

// The complete sample is provided in the global folder that can be used as a reference

{
  "status": 1,
  "data": [
    {
      "questions": [
        {
          "question_id": String,
          "fields": ["abvoe 40km/h", "below 40km/h", "0km/h"],
          "_id": "60dc6a3dc9fe14577c30d271",
          "title": "Please provide the speed of vehicle?",
          "description": "please select one option given below",
          "remark": true,
          "type": "multiple",
          "is_mandatory": true
        }
      ]
    }
  ]
}
```
<br>

### Widget Implementation

```dart
import 'package:flutter/material.dart';
import 'package:simple_form_builder/formbuilder.dart';
import 'package:simple_form_builder/global/constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilder Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                initialData: sampleData,
                index: 0,
                showIndex:true,
                // showPrefix
                //radioIcon
                //checklistIcon
                onSubmit: (val) {
                  print(val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
<br>

## Custom Usage
There are several options that allow for more control:

|  Properties  |   Description   |
|--------------|-----------------|
| `initialData` | This is the map that is required to generate the form. the sample JSON format is given in the constant.dart file |
| `index` | If the data contains mutiple forms passing the index of the form will show the question of that perticular form |
| `onSubmit` | This function will take in the map value and pass it to the given function when submit button is pressed |
| `showPrefix` | This toggle will enable or disable prefix icon before the question |
| `onUpload` | This contains the file uploaded by user in String |
| `showIndex` | to specify weather to show numbering or not |

<br>