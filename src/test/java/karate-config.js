function fn(){
    karate.configure('connectTimeou', 10000);
    karate.configure('readTimeout', 10000);

    return{
        api:{
            baseUrl: "http://api.geonames.org/"
        },
        user:{
            name: 'karate'
        }
    }
}