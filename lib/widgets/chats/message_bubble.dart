import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _msg;
  final bool _isMe;
  final Key _key;
  final String _username;

  const MessageBubble(this._msg, this._isMe, this._key, this._username);

  @override
  Widget build(BuildContext context) {
    return Row(
      key: _key,
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: _isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline6.color,
                ),
              ),
              Text(
                _msg,
                style: TextStyle(
                  color: _isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline6.color,
                ),
                textAlign: _isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
