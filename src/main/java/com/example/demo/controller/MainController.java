package com.example.demo.controller;

import com.example.demo.repo.*;
import com.example.demo.service.CityService;
import com.example.demo.service.QuranDetailService;
import com.example.demo.service.QuranService;
import com.example.demo.service.QuranViewService;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.demo.repo.QuranDictionary;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Pageable;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.example.demo.bean.ReadingJson;

//import java.awt.print.Pageable;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MainController {
    @Autowired
    private CityService cityService;

    @Autowired
    private QuranService qService;

    @Autowired
    private QuranRepository repo;

    @Autowired
    private QuranViewService qvService;

    @Autowired
    private QuranDetailService qdService;
    @Autowired
    private ReadingJson rj;

    private QuranDetail qd;
    @RequestMapping(value = "/test")
    @ResponseBody
    public String home() {

        var city = (List<City>) cityService.getCities();
        City dg = (City) city.get(0);
        return dg.getName();
    }
    @RequestMapping(value = "/home")
    @ResponseBody
    public String getHome()
    {
//        int limit = 500;
//        int offset = 0;
//        int quran_detail_id = 13815;
//        long currentTime = 0;
//        //while(true) {
//            currentTime = System.currentTimeMillis();
//            PageRequest pg = PageRequest.of(offset, limit, Sort.by("id"));
//            List<Quran> qrList = qService.getAll(pg);
//            System.out.println(offset);
//            int i = 0;
//            String[] str;
//            String[] str1;
//            for (Quran qr : qrList) {
//                //System.out.println(qr.getCssStringDetail());
//                str = qr.getEnglishGrammer().split("~");
//                str1 = qr.getCssStringDetail().split("~");
//                for (int j = 0; j < str.length; j++) {
//                    if(i == 0 && j == 0){
//                        System.out.println("ID:" + qr.getId());
//                    }
//                    qd = new QuranDetail();
//                    qd.setId(quran_detail_id);
//                    qd.setQuranId(qr.getId());
//                    qd.setType(str[j]);
//                    qd.setTypeDetail(str1[j]);
//                    qdService.add(qd);
//                    quran_detail_id = quran_detail_id + 1;
//                }
//                i=i+1;
//
//            }
////            if(qrList.size() < limit){
////                break;
////            }
////            if(qrList.size() == 0){
////                break;
////            }
//            offset = offset + 1;
//            //qrList.removeAll();
//
//            System.out.println("TIME SPENT Seconds : " + (System.currentTimeMillis() - currentTime)/1000 );
//        //}
        return "ALL GOOD";
//        return " TEsting 123";
       //ReadingJson rj = new ReadingJson();

//        int i = 38;
//        while (i < 115) {
//            Quran[] qr = rj.readJson(Integer.toString(i));
//            for(Quran qr_entry:qr){
//                qService.add(qr_entry);
//            }
//            i++;
//        }
        //return rj.readVerseJson();

//       return "GOOD JOB";
       //return "WELL DONE";
    }

    @RequestMapping(value = "/getTokens")
    @ResponseBody
    public List<Quran> getTokens(@RequestParam(defaultValue = "1") String verse, @RequestParam(defaultValue = "1") String chapter){
        List<Quran> tokens = repo.findByVerseAndChapter(Integer.parseInt(verse),Integer.parseInt(chapter));
        return tokens;
    }

    @RequestMapping(value = "/")
    public ModelAndView firstPage(@RequestParam(defaultValue = "1") String verse, @RequestParam(defaultValue = "1") String chapter) {
        //System.out.println(repo.findById((long)3600));
        //List<Quran> tokens = repo.findByVerse(Integer.parseInt(verse));
        List<Quran> tokens = repo.findByVerseAndChapter(Integer.parseInt(verse),Integer.parseInt(chapter));
        ModelAndView mv = new ModelAndView("home.jsp");
        mv.addObject("tokens",tokens);
        mv.addObject("verse",verse);
        mv.addObject("chapter",chapter);
        mv.addObject("name","haroon");
        return mv;
    }

    @RequestMapping(value = "/detail2")
    public ModelAndView detail2(){
        ModelAndView mv = new ModelAndView("detail2.jsp");
        return mv;
    }

    @RequestMapping(value = "/usages")
    @ResponseBody
    public List<QuranDictionary> getUsages(@RequestParam(defaultValue = "Elm") String rootWord){
        return this.getQuranList(rootWord);
    }

    @RequestMapping(value = "/detail")
    public ModelAndView detail(@RequestParam(defaultValue = "Elm") String rootWord) {
        //System.out.println(repo.findById((long)3600));
        //List<Quran> tokens = repo.findByVerse(Integer.parseInt(verse));
        ModelAndView mv = new ModelAndView("detail2.jsp");
        mv.addObject("dictionary",this.getQuranList(rootWord));
        //mv.addObject("details",details);
        mv.addObject("rootword",rootWord);
        return mv;
    }

    private List<QuranDictionary> getQuranList(String rootWord){
        List<QuranView> details = qvService.getQuranViewByRootWord(rootWord);
        String myType = "";
        List<QuranDictionary> quranDictionaryList = new ArrayList<QuranDictionary>();
        QuranView quranView;
        QuranDictionary qd;
        qd = new QuranDictionary();
        for(int i =0;i< details.size();i++){
            quranView = details.get(i);
            //System.out.println(quranView.getRootWord() + "---" + rootWord + "--" + quranView.getChapter() + ":" + quranView.getVerse());
            if(!quranView.getRootWord().equals(rootWord)){//query is not made case sensitive so we are comparing it here bdE is different to bDE
                //System.out.println("IGNORING THIS ONE");
                //System.out.println(quranView.getRootWord() + "---" + rootWord + "--" + quranView.getChapter() + ":" + quranView.getVerse());
                if(i + 1 == details.size()){ // last iteration
                    quranDictionaryList.add(qd);
                }
                continue;
            }
            if(!myType.equals(quranView.getTypeDetail())){ // first iteration or change in the details type that is new type
                //System.out.println("ITS NOT EQUAL");
                if(myType == ""){ // first iteration.
                    qd = new QuranDictionary(quranView.getType(),quranView.getTypeDetail(),quranView);
                } else { // change in type that means need to create new Quran dictionary object and old is added to quran dictionary list
                    quranDictionaryList.add(qd);
                    qd =  new QuranDictionary(quranView.getType(),quranView.getTypeDetail(),quranView);
                }
            } else {
                //System.out.println("EQUAL");
                qd.addQuranView(quranView);
            }
            if(i + 1 == details.size()){ // last iteration
                quranDictionaryList.add(qd);
            }
            myType = quranView.getTypeDetail();
        }
        for(int j = 0;j< quranDictionaryList.size();j++){
            qd = quranDictionaryList.get(j);
            //System.out.println(qd.toString());
        }
        return quranDictionaryList;
    }
}
