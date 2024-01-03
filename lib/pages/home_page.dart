import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/wishlist.dart';
import 'package:movies_app/pages/wishlist_page.dart';
import 'package:movies_app/widgets/movies_slider.dart';
import 'package:movies_app/widgets/trending_slider.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> nowPlaying;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies() ;
    topRatedMovies = Api().getTopRatedMovies() ;
    nowPlaying = Api().getNowPlayingMovies() ;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Wishlist>(
        builder:(context,value,child) => Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/netflix.png',
              fit: BoxFit.cover,
              height: 130,
              filterQuality: FilterQuality.high ,
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          drawer: Drawer(
            child: Container(
              color: const Color(0xFF25272E),
              child: ListView(
                children: [
                  DrawerHeader(
                      child: Image.asset('assets/netflix.png')
                  ),
                  ListTile(
                    leading: const Icon(Icons.view_list_rounded),
                    title: const Text('Wishlist',style: TextStyle(fontSize: 20),),
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const WishlistPage()
                    )),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Trending Movies',
                    style: GoogleFonts.aBeeZee(fontSize: 27),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  child: FutureBuilder(
                    future: trendingMovies,
                    builder: (context,snapshot){
                      if(snapshot.hasError){
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if(snapshot.hasData){
                        return TrendingSlider(snapshot: snapshot);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Top Rated Movies',
                    style: GoogleFonts.aBeeZee(fontSize: 27),
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context,snapshot){
                      if(snapshot.hasError){
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if(snapshot.hasData){
                        return MovieSlider(snapshot: snapshot);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Now Playing',
                    style: GoogleFonts.aBeeZee(fontSize: 27),
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: nowPlaying,
                    builder: (context,snapshot){
                      if(snapshot.hasError){
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if(snapshot.hasData){
                        return MovieSlider(snapshot: snapshot);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
