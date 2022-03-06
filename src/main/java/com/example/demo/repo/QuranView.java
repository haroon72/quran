package com.example.demo.repo;

import javax.persistence.*;

@Entity
public class QuranView {
    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public Integer getToken() {
        return token;
    }

    public void setToken(Integer token) {
        this.token = token;
    }

    public Integer getVerse() {
        return verse;
    }

    public void setVerse(Integer verse) {
        this.verse = verse;
    }

    public Integer getChapter() {
        return chapter;
    }

    public void setChapter(Integer chapter) {
        this.chapter = chapter;
    }

    public String getRootWord() {
        return rootWord;
    }

    public void setRootWord(String rootWord) {
        this.rootWord = rootWord;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypeDetail() {
        return typeDetail;
    }

    public void setTypeDetail(String typeDetail) {
        this.typeDetail = typeDetail;
    }

    public String getVerseText() {
        return verseText;
    }

    public void setVerseText(String verseText) {
        this.verseText = verseText;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String english;
    private Integer token;
    private Integer verse;
    private Integer chapter;
    private String rootWord;
    private String type;
    private String typeDetail;
    private String verseText;

    public String getBuckwalter() {
        return buckwalter;
    }

    public void setBuckwalter(String buckwalter) {
        this.buckwalter = buckwalter;
    }

    private String buckwalter;
}
