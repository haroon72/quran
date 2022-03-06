package com.example.demo.repo;

import net.bytebuddy.dynamic.loading.InjectionClassLoader;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Quran {
//    public int getMyChapter() {
//        return myChapter;
//    }
//
//    public void setMyChapter(int myChapter) {
//        this.myChapter = myChapter;
//    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    //private int myChapter;
    private int chapter;
    private int verse;
    private int token;
    private String rootWord;
    private String buckwalter;
    private String english;
    private String img;
    private String arabicGrammer;
    private String cssString;
    private String cssStringDetail;

    public String getEnglishGrammer() {
        return englishGrammer;
    }

    public void setEnglishGrammer(String englishGrammer) {
        this.englishGrammer = englishGrammer;
    }

    private String englishGrammer;

    public String getCssStringDetail() {
        return cssStringDetail;
    }

    public int getChapter() {
        return chapter;
    }

    public void setChapter(int chapter) {
        this.chapter = chapter;
    }

    public int getVerse() {
        return verse;
    }

    public void setVerse(int verse) {
        this.verse = verse;
    }

    public int getToken() {
        return token;
    }

    public void setToken(int token) {
        this.token = token;
    }

    public String getRootWord() {
        return rootWord;
    }

    public void setRootWord(String rootWord) {
        this.rootWord = rootWord;
    }

    public String getBuckwalter() {
        return buckwalter;
    }

    public void setBuckwalter(String buckwalter) {
        this.buckwalter = buckwalter;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getArabicGrammer() {
        return arabicGrammer;
    }

    public void setArabicGrammer(String arabicGrammer) {
        this.arabicGrammer = arabicGrammer;
    }

    public String getCssString() {
        return cssString;
    }

    public void setCssString(String cssString) {
        this.cssString = cssString;
    }

    public void setCssStringDetail(String cssStringDetail) {
        this.cssStringDetail = cssStringDetail;
    }

    @Override
    public String toString() {
        return this.getBuckwalter() + "  " + this.getEnglish();
    }
}
