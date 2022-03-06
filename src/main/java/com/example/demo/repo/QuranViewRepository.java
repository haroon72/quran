package com.example.demo.repo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuranViewRepository extends CrudRepository<QuranView,Long>  {
    List<QuranView> findByRootWord(String rootWord);
    List<QuranView> findByRootWordContainingAndTypeInOrderByTypeDescTypeDetailAsc(String rootWord,List<String> types);
    //@Query("Select qv from quran_view qv where binary rootWord = :rootWord")
    //List<QuranView> findMyQuranView(@Param("name") String rootWord);


}
