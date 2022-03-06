package com.example.demo.service;

import com.example.demo.repo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuranDetailService {

    @Autowired
    private QuranDetailRepository quranDetailR;

    public void add(QuranDetail quranDetail) {
        //System.out.println("HAROON RAshid");
        quranDetailR.save(quranDetail);
    }

    public void delete(long id) {
        quranDetailR.deleteById(id);
    }

    public List<QuranDetail> getAll() {
        return (List<QuranDetail>) quranDetailR.findAll();
    }
}
