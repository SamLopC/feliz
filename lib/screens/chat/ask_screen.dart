import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import '../home/widgets/greeting_header.dart';

class AskScreen extends StatefulWidget {
  const AskScreen({super.key});

  @override
  State<AskScreen> createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  /// Helper to add a message and scroll to the bottom.
  void _addMessage(Map<String, String> message) {
    setState(() {
      _messages.add(message);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  /// Simulate sending a message and getting an AI response.
  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _addMessage({'role': 'user', 'text': text});
    _controller.clear();

    // Simulate system (AI) response after a delay.
    Future.delayed(const Duration(milliseconds: 500), () {
      _addMessage({
        'role': 'ai',
        'text': 'Thanks for your question! I\'ll have more info soon ☀️',
      });
    });
  }

  /// Returns a margin based on the sender.
  EdgeInsets _messageMargin(bool isUser) {
    return isUser
        ? const EdgeInsets.only(left: 0, right: 16, top: 4, bottom: 4)
        : const EdgeInsets.only(left: 16, right: 0, top: 4, bottom: 4);
  }

  /// Builds a chat bubble based on platform and sender.
  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['role'] == 'user';
    final messageText = message['text'] ?? '';

    if (Platform.isIOS) {
      final cupertinoTheme = CupertinoTheme.of(context);
      return Align(
        alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          margin: _messageMargin(isUser),
          child: BubbleSpecialThree(
            isSender: isUser,
            text: messageText,
            color: isUser
                ? CupertinoColors.activeOrange
                : CupertinoColors.lightBackgroundGray,
            tail: true,
            textStyle: TextStyle(
              fontSize: 16,
              color: cupertinoTheme.textTheme.textStyle.color,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
    } else {
      final theme = Theme.of(context);
      return Align(
        alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          margin: _messageMargin(isUser),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser
                ? theme.primaryColor.withOpacity(0.8)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            messageText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
    }
  }

  /// Builds the message area.
  /// If no messages exist, it shows the GreetingHeader widget.
  Widget _buildMessageArea() {
    if (_messages.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              GreetingHeader(key: ValueKey('greeting')),
            ],
          ),
        )
      );
    } else {
      return ListView.builder(
        key: const ValueKey('chatList'),
        controller: _scrollController,
        padding: Platform.isIOS
            ? const EdgeInsets.symmetric(vertical: 16)
            : const EdgeInsets.all(16),
        itemCount: _messages.length,
        itemBuilder: (context, index) => _buildMessage(_messages[index]),
      );
    }
  }

  /// Builds the input area for sending messages.
  Widget _buildInputArea() {
    if (Platform.isIOS) {
      final cupertinoTheme = CupertinoTheme.of(context);
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Row(
          children: [
            Expanded(
              child: CupertinoTextField(
                controller: _controller,
                onSubmitted: (_) => _sendMessage(),
                placeholder: 'Ask me anything about El Paso...',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                style: cupertinoTheme.textTheme.textStyle,
                placeholderStyle: cupertinoTheme.textTheme.textStyle.copyWith(
                  color: cupertinoTheme.brightness == Brightness.dark
                      ? CupertinoColors.inactiveGray
                      : CupertinoColors.systemGrey,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: CupertinoColors.systemGrey, // contour color
                    width: 1.0, // contour width
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _sendMessage,
              child: Icon(
                CupertinoIcons.arrow_up_circle,
                color: cupertinoTheme.primaryColor,
              ),
            ),
          ],
        ),
      );
    } else {
      final theme = Theme.of(context);
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Ask me anything about El Paso...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide:
                    BorderSide(color: theme.primaryColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.send, color: theme.primaryColor),
              onPressed: _sendMessage,
              tooltip: 'Send',
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Wrap the message area in an AnimatedSwitcher so that when _messages changes,
    // the GreetingHeader widget fades out and the chat list fades in.
    final messageArea = Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _buildMessageArea(),
      ),
    );

    if (Platform.isIOS) {
      final cupertinoTheme = CupertinoTheme.of(context);
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Ask Sun City AI',
            style: TextStyle(
              color: cupertinoTheme.primaryColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: cupertinoTheme.textTheme.textStyle.color,
          ),
          child: SafeArea(
            child: Column(
              children: [
                messageArea,
                _buildInputArea(),
              ],
            ),
          ),
        ),
      );
    } else {
      final theme = Theme.of(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'Ask Sun City AI',
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              messageArea,
              const Divider(height: 1),
              _buildInputArea(),
            ],
          ),
        ),
      );
    }
  }
}