package com.semipay.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="vendor")
public class Vendor implements Serializable {
    
    // member variables
    @Id
    @GeneratedValue
    @Column(name="id")
    private int id;
    
    @Column(name="name")
    private String name;
    
    @Column(name="is_active")
    private Boolean isActive;
    
    // getters & setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Boolean getIsActive() {
        return isActive;
    }
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
}