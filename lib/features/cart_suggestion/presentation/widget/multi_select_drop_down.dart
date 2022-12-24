import 'dart:async';

import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/overlay_search_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/drop_down_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiSelectDropDown<T> extends StatefulWidget {
  final String title;
  final Color? customColor;
  final Color? titleColor;
  final IconData? icon;
  final bool showSelected;
  final double? hight;
  const MultiSelectDropDown({
    Key? key,
    required this.items,
    required this.title,
    required this.selected,
    required this.onSubmit,
    this.customColor,
    this.titleColor,
    this.onSearch,
    this.icon,
    this.hight,
    this.showSelected = false,
  }) : super(key: key);

  final List<T> selected;
  final List<DropdownMenuItem<T?>>? items;
  final Function() onSubmit;
  final Future Function(String)? onSearch;
  @override
  State<MultiSelectDropDown> createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown>
    with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  static const double _boxVertPad = 0;
  AnimationController? animationController;
  Animation<double>? animation;
  OverlayEntry? overlayEntry;
  Timer? timer;
  static bool boxVisibility = false;
  TextEditingController controller = TextEditingController();
  OverlaySearchController searchController = Get.put(OverlaySearchController());
  bool isLoading = false;

  Widget? selectedTitle;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
  }

  @override
  Widget build(BuildContext context) {
    generateTitle();

    return WillPopScope(
      onWillPop: () async {
        _hideBox();
        return true;
      },
      child: InkWell(
        key: key,
        onTap: () {
          if (boxVisibility == false) {
            _showbox(context);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 45,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: widget.customColor ?? CBase().dinawinBrown,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: widget.icon != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              selectedTitle == null
                  ? Text(
                      widget.title,
                      maxLines: 1,
                      style: TextStyle(
                        color: widget.titleColor ?? CBase().backgroundColor,
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: selectedTitle),
                    ),
              if (widget.icon == null) SizedBox(),
              widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: CBase().dinawinDarkGrey,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  // *----- show box -----*
  void _showbox(BuildContext context) async {
    FocusNode focusNode = FocusNode();
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        child: StatefulBuilder(builder: (context, setState) {
          focusNode.addListener(() {
            setState(() {});
          });
          return Stack(
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  if (boxVisibility == true) {
                    _hideBox();
                  }
                },
                child: Container(
                  width: CBase().getFullWidth(context),
                  height: CBase().getFullHeight(context),
                  color: Colors.black.withOpacity(0.8),
                ),
              ),

              //*----- dropdown card
              Positioned(
                top: focusNode.hasFocus
                    ? 45
                    : getPosition().dy / (widget.hight ?? 1) + 55 + _boxVertPad,
                child: FadeTransition(
                  opacity: animation!,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: MediaQuery.of(context).size.height / 1.55,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: CBase().dinawinWhite,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),

                          //*----- search
                          if (widget.onSearch != null)
                            DropDownSearch(
                              onSearch: (q) {
                                setState(() {
                                  isLoading = true;
                                });
                                widget.onSearch!(q).then((value) {
                                  isLoading = false;
                                  setState(() {});
                                });
                              },
                              controller: controller,
                              focusNode: focusNode,
                            ),
                          if (widget.onSearch != null) SizedBox(height: 10),

                          //*----- items
                          Expanded(
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : (widget.items ?? []).isEmpty
                                    ? Center(child: Text('موردی یافت نشد'))
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: CBase()
                                              .dinawinDarkGrey
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: widget.items?.length,
                                          itemBuilder: (ctx, i) => Column(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    _onTapHandler(i, setState),
                                                child: customDropDownItem(i),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                          ),
                          SizedBox(height: 10),

                          //*----- submit btn
                          customSubmitBtn(),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
    animationController!.addListener(() {
      overlayState!.setState(() {});
    });
    overlayState!.insert(overlayEntry!);
    animationController!.forward();
    boxVisibility = true;
  }

  // *----- hide box -----*
  void _hideBox() {
    animationController!.reverse().whenComplete(() => overlayEntry!.remove());
    boxVisibility = false;
  }

  Offset getPosition() {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    return position;
  }

  // *----- custom dropdown items
  customDropDownItem(int i) {
    return Row(
      children: [
        Icon(
          widget.selected.contains(widget.items![i].value)
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: widget.selected.contains(widget.items![i].value)
              ? CBase().dinawinBrown
              : CBase().dinawinDarkGrey,
          size: 20,
        ),
        SizedBox(width: 5),
        Container(
          height: 20,
          // color: Colors.amber,
          alignment: Alignment.bottomRight,
          child: widget.items![i].child,
        ),
      ],
    );
  }

  // *----- custom submit btn
  InkWell customSubmitBtn() {
    return InkWell(
      onTap: () {
        widget.onSubmit();
        _hideBox();
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: CBase().dinawinBrown,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            'انتخاب',
            style: TextStyle(
              color: CBase().dinawinWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _onTapHandler(int i, StateSetter setState) {
    setState(() {
      if (widget.selected.contains(widget.items![i].value)) {
        widget.selected.remove(widget.items![i].value);
      } else {
        widget.selected.add(widget.items![i].value);
      }
    });
    generateTitle();
  }

  void generateTitle() {
    if (widget.showSelected) {
      setState(() {
        final List<DropdownMenuItem> _s = (widget.items ?? [])
            .where((e) => widget.selected.contains(e.value))
            .toList();
        if (_s.isNotEmpty) {
          selectedTitle = Row(
            children: _s
                .map((e) => Row(
                      children: [
                        e.child,
                        if (e.value != _s.last.value) Text('/'),
                      ],
                    ))
                .toList(),
          );
        } else {
          selectedTitle = null;
        }
      });
    }
  }
}
