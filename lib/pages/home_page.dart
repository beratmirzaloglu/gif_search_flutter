import 'package:flutter/material.dart';
import 'package:gif_search_flutter/services/http_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _gifNameController = TextEditingController();

  List<dynamic> gifs = [];

  @override
  void initState() {
    getGifs();
    super.initState();
  }

  Future<void> getGifs() async {
    var gifList = await HttpService.searchGif('happy');
    setState(() {
      gifs = gifList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        _buildSearchButton(),
        _buildGifList(),
      ],
    );
  }

  Expanded _buildGifList() {
    return Expanded(
      child: gifs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: gifs.length,
              itemBuilder: (_, index) {
                print(gifs[index]['media'][0]['tinygif']['url']);
                return Container(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(gifs[index]['media'][0]['tinygif']['url']),
                  ),
                );
              },
            ),
    );
  }

  ElevatedButton _buildSearchButton() {
    return ElevatedButton(
      onPressed: () async {
        var gifList = await HttpService.searchGif(_gifNameController.text);
        if (gifList.isNotEmpty) {
          setState(() {
            gifs = gifList;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[400],
      ),
      child: Text(
        'Search GIF',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Padding _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _gifNameController,
        style: TextStyle(
          fontSize: 25,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('GIF Search'),
      centerTitle: true,
    );
  }
}
