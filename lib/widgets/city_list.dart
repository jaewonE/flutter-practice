import 'package:flutter/material.dart';
import 'package:flutterpractice/models/weather.dart';
import 'package:flutterpractice/screens/detail_screen.dart';
import 'package:flutterpractice/services/api_services.dart';
import 'package:flutterpractice/widgets/city_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityList extends StatefulWidget {
  const CityList({super.key});

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  static const storageCityKey = 'citys';
  final TextEditingController _inputController = TextEditingController();
  late final SharedPreferences storage;
  bool hasInitWeather = false;
  List<Weather> weatherList = [];
  List<String> cityList = [];

  Future<void> initWeathers() async {
    storage = await SharedPreferences.getInstance();
    var citys = storage.getStringList(storageCityKey);
    if (citys != null) {
      var futureList = <Future<Weather?>>[];
      for (var i = 0; i < citys.length; i++) {
        futureList.add(ApiServices.getWeatherByCity(city: citys[i]));
      }
      var result = await Future.wait(futureList);
      weatherList = result.whereType<Weather>().toList();
    }
    setState(() {
      hasInitWeather = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initWeathers();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _showWarningPopup({required String title, required String content}) =>
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.of(context).pop()),
                ],
              ));

  void _confirmPopup(
          {required String title,
          required String content,
          required Function onConfirm}) =>
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel")),
                  TextButton(
                      child: const Text("Continue"),
                      onPressed: () {
                        onConfirm();
                        Navigator.of(context).pop();
                      }),
                ],
              ));

  void updateCityList(String city) {
    cityList.add(city);
    storage.setStringList(storageCityKey, cityList);
  }

  void _addNewCity(String city) async {
    if (city == '') return;

    var submitCity = city.toLowerCase().replaceAll(' ', '_');
    Weather? weather = await ApiServices.getWeatherByCity(city: submitCity);
    _inputController.clear();

    if (weather == null) {
      _showWarningPopup(
          title: 'City not exist', content: 'City $city is not exist');
      return;
    }

    setState(() => weatherList.add(weather));
    updateCityList(city);
    _inputController.clear();
  }

  void _submitInput() => _addNewCity(_inputController.text);

  void clearCitys() {
    _confirmPopup(
        title: 'Delete cities',
        content: 'Are you sure you want to delete all cities?',
        onConfirm: () {
          storage.setStringList(storageCityKey, []);
          weatherList = [];
          cityList = [];
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Citys',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 33, 37, 42),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      onPressed: clearCitys,
                      icon: const Icon(Icons.delete_outline_outlined,
                          color: Color.fromRGBO(255, 255, 255, 0.7))),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: _addNewCity,
                    controller: _inputController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(58, 60, 62, 1),
                      hintText: 'Search new citys',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _submitInput,
                  padding: const EdgeInsets.only(left: 10, bottom: 4, right: 0),
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            hasInitWeather
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: weatherList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          city: weatherList[index].city))),
                              child: CityCard(weather: weatherList[index])),
                      separatorBuilder:
                          (BuildContext sepContext, int sepIndex) =>
                              const SizedBox(height: 16),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
