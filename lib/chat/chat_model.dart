import 'package:flutter/material.dart';

class ChatModel {

  final String name;
  final String imageUrl;
  final String message;

  ChatModel({this.name, this.imageUrl, this.message});

  factory ChatModel.formJson (Map json){
    return ChatModel (
      name:json['name'],
      imageUrl:json['imageUrl'],
      message:json['message'],
    );
  }

}