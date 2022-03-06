package com.example.demo.repo;


import java.util.ArrayList;
import java.util.List;

public class QuranDictionary {
    private String parentType;

    public String getParentType() {
        return parentType;
    }

    public void setParentType(String parentType) {
        this.parentType = parentType;
    }

    public List<QuranView> getListQuranView() {
        return listQuranView;
    }

    public void setListQuranView(List<QuranView> listQuranView) {
        this.listQuranView = listQuranView;
    }

    public String getChildType() {
        return childType;
    }

    public void setChildType(String childType) {
        this.childType = childType;
    }

    private String childType;
    private List<QuranView> listQuranView;
    public QuranDictionary(String pt,String ct, QuranView qv){
        this.parentType = pt;
        this.childType = ct;
        this.listQuranView = new ArrayList<QuranView>();
        this.listQuranView.add(qv);
    }
    public QuranDictionary(){

    }
    public boolean addQuranView(QuranView qv){
        this.listQuranView.add(qv);
        return true;
    }
    public String toString(){
        return this.parentType + " -- " + this.childType + " -- " + this.listQuranView.size();
    }

}
