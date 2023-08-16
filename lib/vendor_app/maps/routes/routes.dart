import 'package:flutter/material.dart';


enum MapState { locate,map }

List<Page> onGenerateHomePage(MapState state, List<Page> pages) {
  switch (state) {
    case MapState.locate:
      return [
        
      ];
    case MapState.map:
      return [

      ];
  }
}
