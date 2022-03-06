package com.example.demo.repo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class QuranDetail {
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String type;

    public String getTypeDetail() {
        return typeDetail;
    }

    public void setTypeDetail(String typeDetail) {
        this.typeDetail = typeDetail;
    }

    public long getQuranId() {
        return quranId;
    }

    public void setQuranId(long quranId) {
        this.quranId = quranId;
    }

    private String typeDetail;
    private long quranId;
}
