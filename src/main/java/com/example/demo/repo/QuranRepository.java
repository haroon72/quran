package com.example.demo.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuranRepository extends CrudRepository<Quran,Long> {
    List<Quran> findByVerse(int verse);
    List<Quran> findByVerseAndChapter(int verse,int chapter);
}
