package com.example.demo.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VerseRepository extends CrudRepository<Verse,Long> {
}
