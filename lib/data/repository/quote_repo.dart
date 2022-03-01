

 import 'package:breakingbad/data/model/quote.dart';
import 'package:breakingbad/data/web_services/quote_web_services.dart';

class QuoteRepo {

  late QuoteWebService quoteWebService;

  QuoteRepo(this.quoteWebService);


      Future <List<Quote>> getQuote(String charName)async{

        final quotes = await quoteWebService.getQuote(charName);


        return quotes.map((characterQuote) => Quote.fromJson(characterQuote)).toList() ;


      }

 }