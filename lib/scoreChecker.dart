import 'constants.dart';

int indexScore(List<Carta> scelte) {
  List<int> elencoIndex = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  pairs(scelte) == 1 ? elencoIndex[8] = 1 : elencoIndex[8] = 0;

  pairs(scelte) == 2 ? elencoIndex[7] = 2 : elencoIndex[7] = 0;

  threeOfKind(scelte) ? elencoIndex[6] = 3 : elencoIndex[6] = 0;

  straight(scelte) ? elencoIndex[5] = 4 : elencoIndex[5] = 0;

  flush(scelte) ? elencoIndex[4] = 5 : elencoIndex[4] = 0;

  fullHouse(scelte) ? elencoIndex[3] = 6 : elencoIndex[3] = 0;

  poker(scelte) ? elencoIndex[2] = 7 : elencoIndex[2] = 0;

  straightFlush(scelte) ? elencoIndex[1] = 8 : elencoIndex[1] = 0;

  royalFlush(scelte) ? elencoIndex[0] = 9 : elencoIndex[0] = 0;

  return elencoIndex.indexWhere((element) => element != 0);
}

int pairs(List<Carta> scelte) {
  Map visti = {};
  int coppie = 0;
  for (var item in scelte) {
    if (visti.containsKey(item.numero)) {
      coppie++;
    } else {
      visti[item.numero] = 1;
    }
  }

  return coppie;
}

bool threeOfKind(List<Carta> scelte) {
  Map visti = {};
  for (var item in scelte) {
    if (visti.containsKey(item.numero)) {
      visti[item.numero]++;
    } else {
      visti[item.numero] = 1;
    }
  }
  if (visti.containsValue(3)) {
    return true;
  }
  return false;
}

bool straight(List<Carta> scelte) {
  bool isStraight = true;

  List<Carta> temp = new List<Carta>.from(scelte);
  for (var item in temp) {
    if (item.numero == "J") {
      item.numero = "11";
    } else if (item.numero == "Q") {
      item.numero = "12";
    } else if (item.numero == "K") {
      item.numero = "13";
    } else if (item.numero == "A") {
      item.numero = "14";
    }
  }

  temp.sort((a, b) => int.parse(a.numero).compareTo(int.parse(b.numero)));
  for (int i = 1; i < 5; i++) {
    if (int.parse(temp[i].numero) != int.parse(temp[i - 1].numero) + 1) {
      isStraight = false;
    }
  }

  bool eccezione = 
      temp[4].numero == "14" &&
      temp[0].numero == "2" &&
      temp[1].numero == "3" &&
      temp[2].numero == "4" &&
      temp[3].numero == "5";

  for (var item in temp) {
    if (item.numero == "11") {
      item.numero = "J";
    } else if (item.numero == "12") {
      item.numero = "Q";
    } else if (item.numero == "13") {
      item.numero = "K";
    } else if (item.numero == "14") {
      item.numero = "A";
    }
  }

  if (eccezione) {
    return true;
  }
  return isStraight;
}

bool flush(List<Carta> scelte) {
  String seme = scelte[0].seme;
  for (var scelta in scelte) {
    if (scelta.seme != seme) {
      return false;
    }
  }
  return true;
}

bool fullHouse(List<Carta> scelte) {
  Map visti = {};
  for (var item in scelte) {
    if (visti.containsKey(item.numero)) {
      visti[item.numero]++;
    } else {
      visti[item.numero] = 1;
    }
  }
  if (visti.containsValue(3) && visti.containsValue(2)) {
    return true;
  }
  return false;
}

bool poker(List<Carta> scelte) {
  Map visti = {};
  for (var item in scelte) {
    if (visti.containsKey(item.numero)) {
      visti[item.numero]++;
    } else {
      visti[item.numero] = 1;
    }
  }
  if (visti.containsValue(4)) {
    return true;
  }
  return false;
}

bool straightFlush(List<Carta> scelte) {
  if (straight(scelte) && flush(scelte)) {
    return true;
  }
  return false;
}

bool royalFlush(List<Carta> scelte) {
  if (flush(scelte)) {
    bool isRoyalFlush = scelte.any((element) => element.numero == "10") &&
        scelte.any((element) => element.numero == "J") &&
        scelte.any((element) => element.numero == "Q") &&
        scelte.any((element) => element.numero == "K") &&
        scelte.any((element) => element.numero == "A");
    return isRoyalFlush;
  }
  return false;
}
