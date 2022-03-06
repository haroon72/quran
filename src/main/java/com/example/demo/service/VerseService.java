package com.example.demo.service;

import com.example.demo.repo.Quran;
import com.example.demo.repo.QuranRepository;
import com.example.demo.repo.Verse;
import com.example.demo.repo.VerseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VerseService {

    @Autowired
    private VerseRepository verseR;

    public void add(Verse verse) {
        //System.out.println("HAROON RAshid");
        verseR.save(verse);
    }

    public void delete(long id) {
        verseR.deleteById(id);
    }

    public List<Verse> getAll() {
        return (List<Verse>) verseR.findAll();
    }
}
