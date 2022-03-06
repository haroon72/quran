package com.example.demo.service;

import com.example.demo.model.CityDto;
import com.example.demo.repo.City;
import com.example.demo.repo.CityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class CityService {
    @Autowired
    CityRepository repository1;

    public void add(CityDto dto) {
        repository1.save(toEntity(dto));
    }

    public void delete(long id) {
        repository1.deleteById(id);
    }

    public List<City> getCities() {
        return (List<City>) repository1.findAll();
    }


    private City toEntity(CityDto dto) {
        City entity = new City();
        entity.setName(dto.getName());
        entity.setPopulation(dto.getPopulation());
        return entity;
    }
}