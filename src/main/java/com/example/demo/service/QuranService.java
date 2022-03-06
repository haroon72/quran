package com.example.demo.service;

//import com.example.demo.model.CityDto;
import com.example.demo.repo.Quran;
import com.example.demo.repo.QuranPageRepository;
import com.example.demo.repo.QuranRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

//import java.awt.print.Pageable;
//import java.awt.print.Pageable;
import java.util.List;
import java.util.Optional;

@Component
public class QuranService {
    @Autowired
    QuranRepository quranR;

    @Autowired
    QuranPageRepository quranPageR;

    public void add(Quran quran) {
        //System.out.println("HAROON RAshid");
        quranR.save(quran);
    }

    public void delete(long id) {
        quranR.deleteById(id);
    }

    public List<Quran> getAll() {
        return (List<Quran>) quranR.findAll();
    }

    public List<Quran> getAll(Pageable pg){
        return quranPageR.findAll(pg).toList();
    }



//    private City toEntity(CityDto dto) {
//        City entity = new City();
//        entity.setName(dto.getName());
//        entity.setPopulation(dto.getPopulation());
//        return entity;
//    }
}