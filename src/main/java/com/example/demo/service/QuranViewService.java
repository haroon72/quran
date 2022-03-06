package com.example.demo.service;

import com.example.demo.repo.QuranView;
import com.example.demo.repo.QuranViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class QuranViewService {
    @Autowired
    QuranViewRepository qvRepo;

    public List<QuranView> getQuranViews() {
      return (List<QuranView>)qvRepo.findAll();
    }
    public List<QuranView> getQuranViewByRootWord(String rootWord){
        List<String> types = new ArrayList<String>();
        types.add("N");
        types.add("V");
        types.add("ADJ");

//        types.add("PRON");
//        types.add("RSLT");
//        types.add("REM");
//        types.add("CONJ");
//        types.add("PRP");
//        types.add("INTG");
//        types.add("EMPH");
//        types.add("FUT");
//        types.add("P");
//        types.add("SUP");
//        types.add("COM");
//        types.add("CAUS");
//        types.add("IMPV");
//        types.add("CIRC");
//        types.add("T");

        return (List<QuranView>)qvRepo.findByRootWordContainingAndTypeInOrderByTypeDescTypeDetailAsc(rootWord,types);
    }
}
