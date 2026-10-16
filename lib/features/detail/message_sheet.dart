import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';

Future<void> showMessageSheet(BuildContext context, Destination d) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => MessageSheet(destination: d),
    );

class _Msg {
  const _Msg(this.text, {required this.mine});

  final String text;
  final bool mine;
}

/// A small host chat with quick questions and canned answers.
class MessageSheet extends StatefulWidget {
  const MessageSheet({super.key, required this.destination});

  final Destination destination;

  @override
  State<MessageSheet> createState() => _MessageSheetState();
}

class _MessageSheetState extends State<MessageSheet> {
  final _messages = <_Msg>[];
  final _input = TextEditingController();
  final _scroll = ScrollController();
  bool _typing = false;
  final _asked = <int>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_messages.isEmpty) {
      _messages.add(_Msg(context.l.chatHello(widget.destination.name.of(context.lang)), mine: false));
    }
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send(String text, String reply) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_Msg(text.trim(), mine: true));
      _typing = true;
    });
    _toEnd();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    setState(() {
      _typing = false;
      _messages.add(_Msg(reply, mine: false));
    });
    _toEnd();
  }

  void _toEnd() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scroll.hasClients) {
          _scroll.animateTo(_scroll.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
        }
      });

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final questions = [(l.q1, l.a1), (l.q2, l.a2), (l.q3, l.a3)];
    final height = MediaQuery.sizeOf(context).height * .72;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: G.pad),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: G.blue, shape: BoxShape.circle),
                    child: Text('G', style: outfit(20, weight: FontWeight.w600, color: G.white)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.chatTitle, style: outfit(18, weight: FontWeight.w600)),
                        Row(children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(color: Color(0xFF2BC46C), shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          Text(l.chatHost, style: outfit(13, color: G.muted)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.fromLTRB(G.pad, 8, G.pad, 8),
                itemCount: _messages.length + (_typing ? 1 : 0),
                itemBuilder: (context, i) {
                  if (i == _messages.length) return const _Bubble(text: '•••', mine: false);
                  final m = _messages[i];
                  return Reveal(key: ValueKey(i), index: 0, offset: 10, child: _Bubble(text: m.text, mine: m.mine));
                },
              ),
            ),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: G.pad),
                children: [
                  for (final (i, (q, a)) in questions.indexed)
                    if (!_asked.contains(i))
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(q, style: outfit(14, weight: FontWeight.w500, color: G.blue)),
                          backgroundColor: G.blue.withValues(alpha: .08),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                          onPressed: _typing
                              ? null
                              : () {
                                  setState(() => _asked.add(i));
                                  _send(q, a);
                                },
                        ),
                      ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(G.pad, 8, G.pad, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _input,
                        style: outfit(15),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (t) {
                          _input.clear();
                          _send(t, l.autoReply);
                        },
                        decoration: InputDecoration(
                          hintText: l.typeMessage,
                          hintStyle: outfit(15, color: G.muted),
                          filled: true,
                          fillColor: G.bg,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(26), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleBtn(
                      size: 48,
                      semantics: l.message,
                      onTap: () {
                        final t = _input.text;
                        _input.clear();
                        _send(t, l.autoReply);
                      },
                      child: const Ico(HugeIcons.strokeRoundedSent, size: 22, color: G.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.text, required this.mine});

  final String text;
  final bool mine;

  @override
  Widget build(BuildContext context) => Align(
        alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * .74),
          decoration: BoxDecoration(
            color: mine ? G.blue : G.bg,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(mine ? 20 : 6),
              bottomRight: Radius.circular(mine ? 6 : 20),
            ),
          ),
          child: Text(text, style: outfit(15, color: mine ? G.white : G.ink, height: 1.35)),
        ),
      );
}
