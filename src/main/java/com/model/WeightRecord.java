package com.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "weight_records")
public class WeightRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private float weight;
    private LocalDate date;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public WeightRecord() {}

    public WeightRecord(float weight, LocalDate date, User user) {
        this.weight = weight;
        this.date = date;
        this.user = user;
    }
    public Long getId() {return id;}
    public float getWeight() {return weight;}
    public void setWeight(float weight) {this.weight = weight;}
    public LocalDate getDate() {return date;}
    public void setDate(LocalDate date) {this.date = date;}
    public User getUser() {return user;}
    public void setUser(User user) {this.user = user;}

}
