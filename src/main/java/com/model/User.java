package com.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String fullName;
    @Column(unique = true, nullable = false)
    private String email;
    protected String password;
    private float weight;
    private float goalWeight;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<WorkOut> workout;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<WeightRecord> weightRecords = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Diet> diet;

    public User() {}

    public User(String fullName, String email, String password, float weight, float height, float goalWeight, int age, String gender) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.weight = weight;
        this.goalWeight = goalWeight;
        this.diet = new ArrayList<>();
        this.workout = new ArrayList<>();
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String name) { this.fullName = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public float getWeight() { return weight; }
    public void setWeight(float weight) { this.weight = weight; }



    public float getGoalWeight() { return goalWeight; }
    public void setGoalWeight(float goalWeight) { this.goalWeight = goalWeight; }


    public List<WorkOut> getTasks() { return workout; }
    public void setTasks(List<WorkOut> tasks) { this.workout = tasks; }

    public List<Diet> getDiet() { return diet; }
    public void setDiet(List<Diet> diet) { this.diet = diet; }

    public List<WeightRecord> getWeightRecords() { return weightRecords; }
    public void setWeightRecords(List<WeightRecord> weightRecords) { this.weightRecords = weightRecords; }
}
