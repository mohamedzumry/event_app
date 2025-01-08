import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  const MainAppBar(
      {super.key,
      required this.title,
      required this.automaticallyImplyLeading,
      this.centerTitle,
      this.leading,
      this.actions});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title, overflow: TextOverflow.ellipsis, maxLines: 1),
      centerTitle: widget.centerTitle,
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: widget.leading,
      elevation: 0,
      actions: widget.actions,
      foregroundColor: Colors.white,
      shape: BeveledRectangleBorder(),
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
    );
  }
}
