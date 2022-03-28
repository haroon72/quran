package com.example.demo.bean;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.Map;
import com.example.demo.bean.PageTreeInfo;
import com.example.demo.repo.Quran;
import com.example.demo.repo.Verse;
import com.example.demo.repo.VerseRepository;
import com.example.demo.service.VerseService;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import com.example.demo.service.QuranService;
import com.example.demo.repo.Quran;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReadingJson
{
    @Autowired
    private QuranService quranService;//Testing

    @Autowired
    private VerseService verseService;

    @Autowired
    private VerseRepository verseRepository;

    private static String dataPath = "D:\\projects\\corpusQuran\\Data\\images\\json\\{chapter}.txt";
    private static String versePath = "D:\\projects\\corpusQuran\\Data\\quran-json.txt";
    @SuppressWarnings("unchecked")
    public String readVerseJson(){
        Verse[] verseArray;
        verseArray = new Verse[0];
        int chapter;
        int verse;
        String verseText;
        String chapterText;
        Verse verseObj;
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonNode = mapper.readValue(Paths.get(ReadingJson.versePath).toFile(), JsonNode.class);
            JsonNode array = jsonNode.get("nodes");
            for (JsonNode jn1:array) {
                chapter = jn1.get("@index").asInt();
                chapterText = jn1.get("@name").asText();
                JsonNode verses = jn1.get("aya");
                for(JsonNode jn2:verses){
                    verse = jn2.get("@index").asInt();
                    verseText = jn2.get("@text").asText();
                    verseObj = new Verse();
                    verseObj.setChapter(chapter);
                    verseObj.setVerse(verse);
                    verseObj.setVerseText(verseText);
                    verseObj.setChapterName(chapterText);
                    //verseRepository.save(verseObj);
                    verseService.add(verseObj);
                }
            }
        } catch(Exception ex){
            ex.printStackTrace();
        }
        return "I am DONE";
    }

    public Quran[] readJson(String chapterString)
    {
        String returnString = "";
        Quran myQuran = new Quran();
        Quran[] quranArray;
        quranArray = new Quran[0];
        try {
            // create object mapper instance
            ObjectMapper mapper = new ObjectMapper();
            //mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            // convert JSON file to map
//            Map<?, ?> map = mapper.readValue(Paths.get(ReadingJson.dataPath).toFile(), Map.class);
            //PageTreeInfo pti = mapper.readValue(Paths.get(ReadingJson.dataPath).toFile(), PageTreeInfo.class);
            JsonNode jsonNode = mapper.readValue(Paths.get(ReadingJson.dataPath.replace("{chapter}",chapterString)).toFile(), JsonNode.class);
            JsonNode array = jsonNode.get("nodes");
            String url = "";
            String title = "";
            String thirdOne = "";
            int chapter = 0;
            int verse = 0;
            int token = 0;
            String rootWord = "";
            String buckwalter = "";
            String english = "";
            String img ="";
            String arabicGrammer = "";
            String cssString = "";
            String cssStringDetail = "";
            String englishGrammer = "";
            quranArray = new Quran[array.size()];
            int index = 0;
            for (JsonNode jn1:array) {
                chapter = 0;
                verse = 0;
                token = 0;
                rootWord = "";
                buckwalter = "";
                english = "";
                img ="";
                arabicGrammer = "";
                cssString = "";
                cssStringDetail = "";
                englishGrammer = "";
                url = jn1.get("url").asText();
                title = jn1.get("title").asText();
                thirdOne = jn1.get("thirdOne").asText();
                returnString = returnString + url + title + thirdOne + "<br>";
                Document doc = Jsoup.parse(url);
                Elements els = doc.select("a[href]");
                String temp = "";
                for(Element el:els){
                    temp = el.attr("href");
                    temp = temp.split("=")[1].split("#")[0].toString();
                }
                rootWord = temp;
                url = doc.text();
                String[] arrayOfString = url.split(" ");
                String[] chapterVerseToken = arrayOfString[0].replace("(","").replace(")","").split(":");
                chapter = Integer.parseInt (chapterVerseToken[0]);
                verse = Integer.parseInt (chapterVerseToken[1]);
                token = Integer.parseInt (chapterVerseToken[2]);
                buckwalter = arrayOfString[1];
                for (int i = 2; i < arrayOfString.length; i++) {
                    english = english + arrayOfString[i] + " ";
                }
                english = english.trim();
                Document titleDoc = Jsoup.parse(title);
                Elements elements = titleDoc.select("img");
                String str = "";
                for(Element imageElement : elements){
                    //make sure to get the absolute URL using abs: prefix
                    str = imageElement.attr("sc");
                    if(str.indexOf("=") > -1) break;
                }
                img = str.split("=")[1];
                Document thirdOneDoc = Jsoup.parse(thirdOne);

                Elements elms = thirdOneDoc.getElementsByAttributeValue("class","arabicGrammar"); //("<div class=\"arabicGrammar\">");

                for(Element el:elms){
                    arabicGrammer = el.html().replace("<br>","~");
                }
                thirdOneDoc.getElementsByAttributeValue("class","arabicGrammar").remove();
                elms = thirdOneDoc.select("b[class]");

                String[] css = new String[elms.size()];
                int i = 0;
                for(Element el:elms){
                    css[i] = el.attr("class");
                  i = i + 1;
                }

                elms = thirdOneDoc.select("b");
                String[] grammer = new String[elms.size()];
               i = 0;
                for(Element el:elms){
                    grammer[i] = el.text();
                    i = i + 1;
                }
                englishGrammer = String.join("~",grammer);
                cssString = String.join("~",css);
                thirdOneDoc.select("b[class]").remove();
                cssStringDetail = thirdOneDoc.text().replace(" – ","~").replace("– ","");
                Quran quran = new Quran();
                quran.setChapter(chapter);
                //quran.setMyChapter(verse);
                quran.setVerse(verse);
                quran.setToken(token);
                quran.setRootWord(rootWord);
                quran.setBuckwalter(buckwalter);
                quran.setEnglish(english);
                quran.setImg(img);
                quran.setArabicGrammer(arabicGrammer);
                quran.setCssString(cssString);
                quran.setCssStringDetail(cssStringDetail);
                quran.setEnglishGrammer(englishGrammer);
                //System.out.println(quran.getArabicGrammer());
                //quranService.add(quran);
                //quranService.add(quran);
                //quranService.add(quran);
                quranArray[index] = quran;
                myQuran = quran;
                index = index + 1;

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return quranArray;
    }

}

//    String carJson =
//            "{ \"brand\" : \"Mercedes\", \"doors\" : 5," +
//                    "  \"owners\" : [\"John\", \"Jack\", \"Jill\"]," +
//                    "  \"nestedObject\" : { \"field\" : \"value\" } }";
//
//    ObjectMapper objectMapper = new ObjectMapper();
//
//
//try {
//
//        JsonNode jsonNode = objectMapper.readValue(carJson, JsonNode.class);
//
//        JsonNode brandNode = jsonNode.get("brand");
//        String brand = brandNode.asText();
//        System.out.println("brand = " + brand);
//
//        JsonNode doorsNode = jsonNode.get("doors");
//        int doors = doorsNode.asInt();
//        System.out.println("doors = " + doors);
//
//        JsonNode array = jsonNode.get("owners");
//        JsonNode jsonNode = array.get(0);
//        String john = jsonNode.asText();
//        System.out.println("john  = " + john);
//
//        JsonNode child = jsonNode.get("nestedObject");
//        JsonNode childField = child.get("field");
//        String field = childField.asText();
//        System.out.println("field = " + field);
//
//        } catch (IOException e) {
//        e.printStackTrace();
//        }